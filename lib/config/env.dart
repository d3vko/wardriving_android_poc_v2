import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración desde `.env` (paridad BuildConfig v1).
class Env {
  Env._();

  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ??
      'https://wardriving-ctf.rf-village-mx.com/wardriving/api/v1/';

  static String get loginPath =>
      dotenv.env['API_LOGIN_PATH'] ?? 'auth/login/';

  static String get registerPath =>
      dotenv.env['API_REGISTER_PATH'] ?? 'auth/register/';

  static String get passwordRecoveryPath =>
      dotenv.env['API_PASSWORD_RECOVERY_PATH'] ?? 'auth/password/reset/';

  static String get uploadPath =>
      dotenv.env['API_UPLOAD_PATH'] ?? 'files-uploaded/';

  /// Paridad v1: no usar *_flutter salvo que el backend lo exija.
  static String get wifiBleUploadType =>
      dotenv.env['API_UPLOAD_TYPE_WIFI_BLE'] ?? 'wifi_ble_android';

  static String get lteUploadType =>
      dotenv.env['API_UPLOAD_TYPE_LTE'] ?? 'lte_android';

  static String get mapLibreStyleUrl =>
      dotenv.env['MAPLIBRE_STYLE_URL'] ??
      'https://demotiles.maplibre.org/style.json';

  static Color get accentColor {
    final raw = dotenv.env['APP_ACCENT_COLOR'] ?? '#00A676';
    final hex = raw.replaceFirst('#', '');
    final value = int.tryParse(hex, radix: 16);
    if (value == null) return const Color(0xFF00A676);
    if (hex.length == 6) return Color(0xFF000000 | value);
    if (hex.length == 8) return Color(value);
    return const Color(0xFF00A676);
  }
}
