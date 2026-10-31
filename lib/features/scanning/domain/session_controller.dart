import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/db/database.dart';
import '../../../core/models/models.dart';
import '../../../core/permissions/wardriving_permissions.dart';
import '../../export/data/export_repository.dart';
import '../../settings/data/app_settings_store.dart';
import '../data/rf_scanners_bridge.dart';
import 'wardriving_repository.dart';

@pragma('vm:entry-point')
void wardrivingTaskCallback() {
  FlutterForegroundTask.setTaskHandler(_WardrivingTaskHandler());
}

class _WardrivingTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {
    FlutterForegroundTask.sendDataToMain({
      'tick': timestamp.millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
}

final sessionControllerProvider =
    StateNotifierProvider<SessionController, LiveCounters>((ref) {
  return SessionController(ref);
});

class SessionController extends StateNotifier<LiveCounters> {
  SessionController(this._ref) : super(const LiveCounters()) {
    _initForegroundTask();
    _restoreActive();
  }

  final Ref _ref;
  final RfScannersBridge _bridge = RfScannersBridge();
  final DuplicateFilter _dedupe = DuplicateFilter();

  Timer? _loopTimer;
  StreamSubscription<Position>? _locationSub;
  StreamSubscription<LiveCounters>? _countersSub;
  StreamSubscription<List<Map<String, dynamic>>>? _wifiResultsSub;
  StreamSubscription<List<ScanResult>>? _bleResultsSub;
  GeoLocation? _latestLocation;
  bool _paused = false;
  String? _sessionId;
  int _sessionStartedAt = 0;
  bool _busy = false;
  bool _lteBusy = false;
  int _lastWifiRequestAt = 0;
  int _lastNotifyAt = 0;
  bool _fgsListening = false;

  /// Epoch ms before ~2000-01-01 — values below this are boot-time or garbage.
  static const int _minCredibleEpochMs = 946684800000;

  WardrivingRepository get _repo => _ref.read(wardrivingRepositoryProvider);
  AppSettingsStore get _settings => _ref.read(appSettingsStoreProvider);

  void _initForegroundTask() {
    try {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'wardriving_collection',
        channelName: 'Wardriving session',
        channelDescription: 'Sesión de recolección RF activa',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(ScanCadence.fgsHeartbeatMillis),
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    } catch (_) {
      // Tests / Android 16: no tumbar el primer frame.
    }
  }

  Future<void> _restoreActive() async {
    try {
    final active = await _repo.getActiveSession();
    if (active == null) return;
    _sessionId = active.id;
    _sessionStartedAt = active.startedAt;
    _paused = active.status == 'PAUSED';
    state = state.copyWith(
      sessionId: active.id,
      sessionStatus:
          _paused ? SessionStatus.paused : SessionStatus.running,
    );
    _subscribeCounters(active.id);
    } catch (_) {}
  }

  void _subscribeCounters(String sessionId) {
    _countersSub?.cancel();
    _countersSub = _repo.observeCounters(sessionId).listen((counters) {
      state = counters.copyWith(
        sessionStatus: _paused
            ? SessionStatus.paused
            : (_sessionId == null
                ? SessionStatus.stopped
                : SessionStatus.running),
        sessionId: sessionId,
        uploadStatus: state.uploadStatus,
      );
    });
  }

  Future<void> start() async {
    if (_busy) return;
    _busy = true;
    try {
      final granted = await WardrivingPermissions.requestAll();
      if (!granted) {
        throw StateError('Permisos insuficientes para iniciar la sesión');
      }

      final settings = _settings.readSettings();
      final active = await _repo.getActiveSession();
      final session = active ??
          await _repo.startSession(settings, 'wifi_ble_android');
      _sessionId = session.id;
      _sessionStartedAt = session.startedAt;
      _paused = false;
      _dedupe.clear();
      _subscribeCounters(session.id);

      await _startForeground('Wardriving session active');
      await _startLocation(settings);
      await _startRadios(settings);
      _startLoop(settings);
      _listenFgsTicks();

      state = state.copyWith(
        sessionId: session.id,
        sessionStatus: SessionStatus.running,
        uploadStatus: 'Idle',
        scanHint: _cadenceHint(settings),
        wifiThrottled: false,
      );
    } finally {
      _busy = false;
    }
  }

  Future<void> pause() async {
    final id = _sessionId;
    if (id == null) return;
    _paused = true;
    await _repo.pauseSession(id);
    await FlutterForegroundTask.updateService(
      notificationTitle: 'Wardriving',
      notificationText: 'Wardriving session paused',
    );
    state = state.copyWith(sessionStatus: SessionStatus.paused);
  }

  Future<void> resume() async {
    final id = _sessionId;
    if (id == null) return;
    _paused = false;
    await _repo.resumeSession(id);
    await FlutterForegroundTask.updateService(
      notificationTitle: 'Wardriving',
      notificationText: 'Wardriving session active',
    );
    state = state.copyWith(sessionStatus: SessionStatus.running);
  }

  Future<void> stop() async {
    if (_busy) return;
    _busy = true;
    try {
      final id = _sessionId;
      _sessionId = null;
      _sessionStartedAt = 0;
      _paused = false;
      _loopTimer?.cancel();
      _loopTimer = null;
      await _stopRadios();
      await _locationSub?.cancel();
      _locationSub = null;
      await _countersSub?.cancel();
      _countersSub = null;

      if (id != null) {
        await _repo.stopSession(id);
        final settings = _settings.readSettings();
        if (settings.localCsvExport || settings.uploadAfterSession) {
          state = state.copyWith(uploadStatus: 'Exporting…');
          final exportRepo = _ref.read(exportRepositoryProvider);
          try {
            if (settings.uploadAfterSession) {
              await exportRepo.enqueueExportsForUpload(id);
              final uploadRepo = _ref.read(uploadRepositoryProvider);
              await uploadRepo.uploadSessionPending(id);
              state = state.copyWith(uploadStatus: 'Uploaded');
            } else if (settings.localCsvExport) {
              await exportRepo.exportSession(id);
              state = state.copyWith(uploadStatus: 'Exported');
            }
          } catch (e) {
            state = state.copyWith(uploadStatus: 'Error: $e');
          }
        }
      }

      await FlutterForegroundTask.stopService();
      state = const LiveCounters(sessionStatus: SessionStatus.stopped);
    } finally {
      _busy = false;
    }
  }

  Future<void> _startForeground(String text) async {
    final running = await FlutterForegroundTask.isRunningService;
    if (running) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Wardriving',
        notificationText: text,
      );
      return;
    }
    await FlutterForegroundTask.startService(
      serviceId: 33420,
      notificationTitle: 'Wardriving',
      notificationText: text,
      notificationIcon: const NotificationIcon(
        metaDataName: 'com.d3vk0.wardriving.NOTIFICATION_ICON',
      ),
      callback: wardrivingTaskCallback,
    );
  }

  Future<void> _startLocation(SessionSettings settings) async {
    await _locationSub?.cancel();
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return;

    _locationSub = Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        intervalDuration: const Duration(seconds: 1),
      ),
    ).listen((pos) async {
      final geo = GeoLocation(
        timestamp: pos.timestamp.millisecondsSinceEpoch,
        latitude: pos.latitude,
        longitude: pos.longitude,
        altitudeMeters: pos.altitude,
        accuracyMeters: pos.accuracy,
        speedMetersPerSecond: pos.speed,
        bearingDegrees: pos.heading,
      );
      _latestLocation = geo;
      final id = _sessionId;
      if (id != null) {
        await _repo.insertLocation(id, geo);
      }
      if (!_paused) {
        state = state.copyWith(gpsStatus: 'Fix ${pos.accuracy.toStringAsFixed(0)} m');
      }
    });
  }

  void _startLoop(SessionSettings settings) {
    _loopTimer?.cancel();
    _tickRadios(settings);
    _loopTimer = Timer.periodic(
      Duration(milliseconds: settings.sampleIntervalMillis),
      (_) => _tickRadios(settings),
    );
  }

  void _listenFgsTicks() {
    if (_fgsListening) return;
    FlutterForegroundTask.addTaskDataCallback(_onFgsTick);
    _fgsListening = true;
  }

  void _onFgsTick(Object data) {
    if (_paused || _sessionId == null) return;
    _tickRadios(_settings.readSettings());
  }

  void _tickRadios(SessionSettings settings) {
    if (_paused || _sessionId == null) return;
    if (settings.wifiEnabled) {
      unawaited(_requestWifiScan());
    }
    if (settings.lteEnabled) {
      unawaited(_pollLte(_sessionId!));
    }
    unawaited(_refreshNotification());
  }

  Future<void> _startRadios(SessionSettings settings) async {
    await _stopRadios();
    if (settings.wifiEnabled) {
      try {
        await _bridge.wifiSetActive(true);
        final throttled = await _bridge.wifiIsThrottleEnabled();
        state = state.copyWith(wifiThrottled: throttled);
        _wifiResultsSub = _bridge.wifiScanResults().listen(_ingestWifi);
      } catch (_) {}
    }
    if (settings.bleEnabled) {
      await _startBleContinuous();
    }
  }

  Future<void> _stopRadios() async {
    await _wifiResultsSub?.cancel();
    _wifiResultsSub = null;
    await _bleResultsSub?.cancel();
    _bleResultsSub = null;
    try {
      if (FlutterBluePlus.isScanningNow) {
        await FlutterBluePlus.stopScan();
      }
    } catch (_) {}
    try {
      await _bridge.wifiSetActive(false);
    } catch (_) {}
    if (_fgsListening) {
      FlutterForegroundTask.removeTaskDataCallback(_onFgsTick);
      _fgsListening = false;
    }
  }

  Future<void> _requestWifiScan() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastWifiRequestAt < 400) return;
    _lastWifiRequestAt = now;
    try {
      final ok = await _bridge.wifiStartScan();
      if (!ok && !state.wifiThrottled) {
        state = state.copyWith(wifiThrottled: true);
      }
    } catch (_) {}
  }

  Future<void> _ingestWifi(List<Map<String, dynamic>> results) async {
    final sessionId = _sessionId;
    if (sessionId == null || _paused) return;
    final location = _latestLocation;
    final now = DateTime.now().millisecondsSinceEpoch;
    final samples = <WifiBleSamplesCompanion>[];
    for (final r in results) {
      final mac = (r['bssid'] as String?) ?? '';
      if (mac.isEmpty) continue;
      if (!_dedupe.shouldKeep('wifi:$mac', now)) continue;
      final freq = (r['frequency'] as num?)?.toInt() ?? 0;
      samples.add(
        WifiBleSamplesCompanion.insert(
          sessionId: sessionId,
          timestamp: now,
          type: 'WIFI',
          mac: mac,
          ssid: (r['ssid'] as String?) ?? '',
          authMode: (r['capabilities'] as String?) ?? '',
          channel: frequencyToChannel(freq).toString(),
          rssi: Value((r['level'] as num?)?.toInt()),
          latitude: Value(location?.latitude),
          longitude: Value(location?.longitude),
          altitudeMeters: Value(location?.altitudeMeters),
          accuracyMeters: Value(location?.accuracyMeters),
          rawPayload: Value('frequency=$freq'),
        ),
      );
    }
    if (samples.isNotEmpty) await _repo.insertWifiBle(samples);
  }

  Future<void> _startBleContinuous() async {
    if (await FlutterBluePlus.isSupported == false) return;
    final adapterOn = await FlutterBluePlus.adapterState.first.timeout(
      const Duration(seconds: 2),
      onTimeout: () => BluetoothAdapterState.off,
    );
    if (adapterOn != BluetoothAdapterState.on) return;

    _bleResultsSub = FlutterBluePlus.onScanResults.listen(_ingestBle);
    try {
      await FlutterBluePlus.startScan(
        continuousUpdates: true,
        androidScanMode: AndroidScanMode.lowLatency,
        androidUsesFineLocation: true,
      );
    } catch (_) {}
  }

  Future<void> _ingestBle(List<ScanResult> results) async {
    final sessionId = _sessionId;
    if (sessionId == null || _paused) return;
    final location = _latestLocation;
    final now = DateTime.now().millisecondsSinceEpoch;
    final samples = <WifiBleSamplesCompanion>[];
    for (final r in results) {
      final mac = r.device.remoteId.str;
      if (!_dedupe.shouldKeep('ble:$mac', now)) continue;
      samples.add(
        WifiBleSamplesCompanion.insert(
          sessionId: sessionId,
          timestamp: now,
          type: 'BLE',
          mac: mac,
          ssid: r.advertisementData.advName,
          authMode: 'BLE',
          channel: '',
          rssi: Value(r.rssi),
          latitude: Value(location?.latitude),
          longitude: Value(location?.longitude),
          altitudeMeters: Value(location?.altitudeMeters),
          accuracyMeters: Value(location?.accuracyMeters),
        ),
      );
    }
    if (samples.isNotEmpty) await _repo.insertWifiBle(samples);
  }

  Future<void> _pollLte(String sessionId) async {
    if (_lteBusy) return;
    _lteBusy = true;
    try {
      final location = _latestLocation;
      final results = await _bridge.telephonyGetCellInfo();
      final samples = <LteSamplesCompanion>[];
      for (final r in results) {
        final rawTs = (r['timestamp'] as num?)?.toInt();
        final now = _sanitizeLteTimestamp(rawTs);
        final mcc = r['mcc'] as String?;
        final mnc = r['mnc'] as String?;
        final lac = (r['lac'] as num?)?.toInt();
        final cellId = (r['cellId'] as num?)?.toInt();
        if (!_dedupe.shouldKeep('lte:$mcc:$mnc:$lac:$cellId', now)) {
          continue;
        }
        samples.add(
          LteSamplesCompanion.insert(
            sessionId: sessionId,
            timestamp: now,
            technology: (r['technology'] as String?) ?? 'LTE',
            state: (r['state'] as String?) ?? '',
            mcc: Value(mcc),
            mnc: Value(mnc),
            lac: Value(lac),
            cellId: Value(cellId),
            pci: Value((r['pci'] as num?)?.toInt()),
            earfcn: Value((r['earfcn'] as num?)?.toInt()),
            band: Value(r['band'] as String?),
            rssi: Value((r['rssi'] as num?)?.toInt()),
            rsrp: Value((r['rsrp'] as num?)?.toInt()),
            rsrq: Value((r['rsrq'] as num?)?.toInt()),
            sinr: Value((r['sinr'] as num?)?.toInt()),
            operatorName: Value(r['operator'] as String?),
            longitude: Value(location?.longitude),
            latitude: Value(location?.latitude),
            rawPayload: Value(r['rawPayload'] as String?),
          ),
        );
      }
      if (samples.isNotEmpty) await _repo.insertLte(samples);
    } catch (_) {
    } finally {
      _lteBusy = false;
    }
  }

  Future<void> _refreshNotification() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastNotifyAt < ScanCadence.fgsHeartbeatMillis) return;
    _lastNotifyAt = now;
    await FlutterForegroundTask.updateService(
      notificationTitle: 'Wardriving',
      notificationText:
          'Wi‑Fi ${state.wifiCount} · BLE ${state.bleCount} · LTE ${state.lteCount}',
    );
  }

  String _cadenceHint(SessionSettings settings) {
    final seconds = (settings.sampleIntervalMillis / 1000).toStringAsFixed(
      settings.sampleIntervalMillis % 1000 == 0 ? 0 : 1,
    );
    return 'Wi‑Fi cada ${seconds}s · BLE continuo · LTE en paralelo';
  }

  int _sanitizeLteTimestamp(int? rawTs) {
    final wall = DateTime.now().millisecondsSinceEpoch;
    if (rawTs == null) return wall;
    if (rawTs < _minCredibleEpochMs) return wall;
    if (_sessionStartedAt > 0 && rawTs < _sessionStartedAt) return wall;
    return rawTs;
  }

  @override
  void dispose() {
    _loopTimer?.cancel();
    unawaited(_stopRadios());
    _locationSub?.cancel();
    _countersSub?.cancel();
    super.dispose();
  }
}

/// Ensure WidgetsFlutterBinding for FGS communication.
void ensureSessionBindings() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();
}
