import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/models.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main()');
});

final appSettingsStoreProvider = Provider<AppSettingsStore>((ref) {
  return AppSettingsStore(ref.watch(sharedPreferencesProvider));
});

final sessionSettingsProvider = StreamProvider<SessionSettings>((ref) {
  return ref.watch(appSettingsStoreProvider).watchSettings();
});

final sessionFilterProvider = StreamProvider<SessionFilter>((ref) {
  return ref.watch(appSettingsStoreProvider).watchSessionFilter();
});

class AppSettingsStore {
  AppSettingsStore(this._prefs);

  final SharedPreferences _prefs;

  static const _interval = 'sample_interval_millis';
  static const _wifi = 'wifi_enabled';
  static const _ble = 'ble_enabled';
  static const _lte = 'lte_enabled';
  static const _upload = 'upload_after_session';
  static const _export = 'local_csv_export';
  static const _keepAwake = 'keep_screen_awake';
  static const _uploadDefaultApplied = 'upload_default_applied_for_jwt';
  static const _sessionFilter = 'session_filter';

  SessionSettings readSettings() {
    return SessionSettings(
      sampleIntervalMillis: _prefs.getInt(_interval) ?? 20000,
      wifiEnabled: _prefs.getBool(_wifi) ?? true,
      bleEnabled: _prefs.getBool(_ble) ?? true,
      lteEnabled: _prefs.getBool(_lte) ?? true,
      uploadAfterSession: _prefs.getBool(_upload) ?? false,
      localCsvExport: _prefs.getBool(_export) ?? true,
      keepScreenAwake: _prefs.getBool(_keepAwake) ?? false,
    );
  }

  SessionFilter readSessionFilter() =>
      SessionFilter.fromStorage(_prefs.getString(_sessionFilter));

  Stream<SessionSettings> watchSettings() async* {
    yield readSettings();
    // SharedPreferences has no native stream; UI refreshes via notifier.
  }

  Stream<SessionFilter> watchSessionFilter() async* {
    yield readSessionFilter();
  }

  Future<void> update(SessionSettings Function(SessionSettings) transform) async {
    final next = transform(readSettings());
    await _prefs.setInt(_interval, next.sampleIntervalMillis);
    await _prefs.setBool(_wifi, next.wifiEnabled);
    await _prefs.setBool(_ble, next.bleEnabled);
    await _prefs.setBool(_lte, next.lteEnabled);
    await _prefs.setBool(_upload, next.uploadAfterSession);
    await _prefs.setBool(_export, next.localCsvExport);
    await _prefs.setBool(_keepAwake, next.keepScreenAwake);
  }

  Future<void> enableUploadByDefaultForAuthenticatedUser() async {
    if (_prefs.getBool(_uploadDefaultApplied) == true) return;
    await _prefs.setBool(_upload, true);
    await _prefs.setBool(_uploadDefaultApplied, true);
  }

  Future<void> saveSessionFilter(SessionFilter filter) async {
    await _prefs.setString(_sessionFilter, filter.name);
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SessionSettings>((ref) {
  final store = ref.watch(appSettingsStoreProvider);
  return SettingsController(store);
});

class SettingsController extends StateNotifier<SessionSettings> {
  SettingsController(this._store) : super(_store.readSettings());

  final AppSettingsStore _store;

  Future<void> update(SessionSettings Function(SessionSettings) transform) async {
    await _store.update(transform);
    state = _store.readSettings();
  }

  Future<void> setFilter(SessionFilter filter) async {
    await _store.saveSessionFilter(filter);
  }

  SessionFilter get filter => _store.readSessionFilter();
}
