import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/database.dart';
import '../../../core/models/models.dart';

final wardrivingRepositoryProvider = Provider<WardrivingRepository>((ref) {
  return WardrivingRepository(ref.watch(databaseProvider));
});

class WardrivingRepository {
  WardrivingRepository(this._db);

  final WardrivingDatabase _db;
  static const _uuid = Uuid();

  Stream<List<WardrivingSession>> observeSessions() => _db.observeSessions();

  Future<List<WardrivingSession>> listSessions() => _db.getAllSessions();

  Future<WardrivingSession?> getActiveSession() => _db.getActiveSession();

  Future<WardrivingSession?> getSession(String id) => _db.getSession(id);

  Future<WardrivingSession> startSession(
    SessionSettings settings,
    String deviceSource,
  ) async {
    final id = _uuid.v4();
    await _db.upsertSession(
      WardrivingSessionsCompanion.insert(
        id: id,
        startedAt: DateTime.now().millisecondsSinceEpoch,
        status: SessionStatus.running.name.toUpperCase(),
        deviceSource: deviceSource,
        wifiEnabled: settings.wifiEnabled,
        bleEnabled: settings.bleEnabled,
        lteEnabled: settings.lteEnabled,
        uploaded: const Value(false),
      ),
    );
    return (await _db.getSession(id))!;
  }

  Future<void> pauseSession(String sessionId) => _db.updateSessionStatus(
        sessionId,
        SessionStatus.paused.name.toUpperCase(),
        null,
      );

  Future<void> resumeSession(String sessionId) => _db.updateSessionStatus(
        sessionId,
        SessionStatus.running.name.toUpperCase(),
        null,
      );

  Future<bool> stopSession(String sessionId) async {
    final n = await _db.finishActiveSession(
      sessionId,
      DateTime.now().millisecondsSinceEpoch,
    );
    return n == 1;
  }

  Future<void> markSessionExported(
    String sessionId,
    String localExportPath, {
    bool uploaded = false,
  }) {
    return _db.updateSessionExport(
      sessionId,
      uploaded: uploaded,
      localExportPath: localExportPath,
    );
  }

  Future<void> insertLocation(String sessionId, GeoLocation location) {
    return _db.insertLocation(
      LocationSamplesCompanion.insert(
        sessionId: sessionId,
        timestamp: location.timestamp,
        latitude: location.latitude,
        longitude: location.longitude,
        altitudeMeters: Value(location.altitudeMeters),
        accuracyMeters: Value(location.accuracyMeters),
        speedMetersPerSecond: Value(location.speedMetersPerSecond),
        bearingDegrees: Value(location.bearingDegrees),
      ),
    );
  }

  Future<void> insertWifiBle(List<WifiBleSamplesCompanion> samples) =>
      _db.insertWifiBle(samples);

  Future<void> insertLte(List<LteSamplesCompanion> samples) =>
      _db.insertLte(samples);

  Stream<LiveCounters> observeCounters(String sessionId) {
    return Stream.multi((controller) {
      var wifi = 0;
      var ble = 0;
      var lte = 0;
      LocationSample? location;

      void emit() {
        controller.add(
          LiveCounters(
            wifiCount: wifi,
            bleCount: ble,
            lteCount: lte,
            gpsStatus: location == null
                ? 'Waiting'
                : 'Locked ${location!.latitude}, ${location!.longitude}',
            sessionId: sessionId,
          ),
        );
      }

      final subs = [
        _db.observeWifiCount(sessionId).listen((v) {
          wifi = v;
          emit();
        }),
        _db.observeBleCount(sessionId).listen((v) {
          ble = v;
          emit();
        }),
        _db.observeLteCount(sessionId).listen((v) {
          lte = v;
          emit();
        }),
        _db.observeLatestLocation(sessionId).listen((v) {
          location = v;
          emit();
        }),
      ];
      controller.onCancel = () {
        for (final s in subs) {
          s.cancel();
        }
      };
    });
  }

  Stream<List<MapPin>> observeLatestMapPins([String? sessionId]) {
    return Stream.multi((controller) {
      List<WifiBleSample> wifiBle = [];
      List<LteSample> lte = [];

      void emit() {
        controller.add(combineMapPins(wifiBle, lte));
      }

      final subs = [
        _db.observeGeolocatedWifiBle(sessionId).listen((v) {
          wifiBle = v;
          emit();
        }),
        _db.observeGeolocatedLte(sessionId).listen((v) {
          lte = v;
          emit();
        }),
      ];
      controller.onCancel = () {
        for (final s in subs) {
          s.cancel();
        }
      };
    });
  }

  Future<List<WifiBleSample>> getWifiBleSamples(String sessionId) =>
      _db.getWifiBleSamples(sessionId);

  Future<List<LteSample>> getLteSamples(String sessionId) =>
      _db.getLteSamples(sessionId);

  Future<void> deleteAllLocalData() async {
    final sessions = await _db.getAllSessions();
    final exportPaths = sessions
        .expand((s) => (s.localExportPath ?? '').split(';'))
        .where((p) => p.isNotEmpty);
    final pending = await _db.getAllPendingUploads();
    for (final path in [...exportPaths, ...pending.map((p) => p.filePath)]) {
      try {
        final file = File(path);
        if (await file.exists()) await file.delete();
      } catch (_) {}
    }
    await _db.deleteAllLocalData();
  }
}

List<MapPin> combineMapPins(
  List<WifiBleSample> wifiBle,
  List<LteSample> lte,
) {
  final pins = <MapPin>[];
  for (final s in wifiBle) {
    if (s.latitude == null || s.longitude == null) continue;
    pins.add(
      MapPin(
        id: 'wb-${s.id}',
        sessionId: s.sessionId,
        type: s.type == 'BLE' ? MapPinType.ble : MapPinType.wifi,
        label: s.ssid.isNotEmpty ? s.ssid : s.mac,
        latitude: s.latitude!,
        longitude: s.longitude!,
        timestamp: s.timestamp,
        rssiOrSignal: s.rssi,
      ),
    );
  }
  for (final s in lte) {
    if (s.latitude == null || s.longitude == null) continue;
    pins.add(
      MapPin(
        id: 'lte-${s.id}',
        sessionId: s.sessionId,
        type: MapPinType.lte,
        label: '${s.mcc ?? '?'}-${s.mnc ?? '?'}-${s.cellId ?? '?'}',
        latitude: s.latitude!,
        longitude: s.longitude!,
        timestamp: s.timestamp,
        rssiOrSignal: s.rsrp ?? s.rssi,
      ),
    );
  }
  pins.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return pins;
}
