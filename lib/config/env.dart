import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración desde `.env` (paridad BuildConfig v1).
///
/// Si falta el asset, los getters caen a defaults de producción para que
/// el arranque (y Sentry) no dependan de un `.env` gitignorado.
class Env {
  Env._();

  static const defaultBaseUrl =
      'https://wardriving-ctf.rf-village-mx.com/wardriving/api/v1/';

  static const defaultSentryDsn =
      'https://9d05a42f89684dc2b5bace58f65a36ed@errors-handler.rf-village-mx.com/3';

  static String? _env(String key) {
    if (!dotenv.isInitialized) return null;
    final value = dotenv.env[key];
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  /// Carga `.env` o `.env.example`. Nunca lanza: Sentry y la API tienen fallback.
  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
      return;
    } catch (_) {}
    try {
      await dotenv.load(fileName: '.env.example');
    } catch (_) {
      dotenv.loadFromString(envString: '');
    }
  }

  static String get baseUrl => _env('API_BASE_URL') ?? defaultBaseUrl;

  static String get loginPath => _env('API_LOGIN_PATH') ?? 'auth/login/';

  static String get registerPath => _env('API_REGISTER_PATH') ?? 'auth/register/';

  static String get passwordRecoveryPath =>
      _env('API_PASSWORD_RECOVERY_PATH') ?? 'auth/password/reset/';

  static String get uploadPath => _env('API_UPLOAD_PATH') ?? 'files-uploaded/';

  /// Paridad v1: no usar *_flutter salvo que el backend lo exija.
  static String get wifiBleUploadType =>
      _env('API_UPLOAD_TYPE_WIFI_BLE') ?? 'wifi_ble_android';

  static String get lteUploadType => _env('API_UPLOAD_TYPE_LTE') ?? 'lte_android';

  static String get mapLibreStyleUrl =>
      _env('MAPLIBRE_STYLE_URL') ?? 'https://demotiles.maplibre.org/style.json';

  static String get sentryDsn => _env('SENTRY_DSN') ?? defaultSentryDsn;

  static String get versionName => _env('APP_VERSION_NAME') ?? '0.0.3';

  static String get versionCode => _env('APP_VERSION_CODE') ?? '5';

  static String get releaseName =>
      'wardriving_rf_village_mx@$versionName+$versionCode';

  static Color get accentColor {
    final raw = _env('APP_ACCENT_COLOR') ?? '#4EE08A';
    final hex = raw.replaceFirst('#', '');
    final value = int.tryParse(hex, radix: 16);
    if (value == null) return const Color(0xFF4EE08A);
    if (hex.length == 6) return Color(0xFF000000 | value);
    if (hex.length == 8) return Color(value);
    return const Color(0xFF4EE08A);
  }
}
