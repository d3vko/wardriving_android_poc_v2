import 'package:crypto/crypto.dart';

/// Pinning TLS para hosts de RF Village MX.
///
/// Flutter/Dart no confía CAs de usuario (Burp típico ya falla). Además:
/// - `findProxy = DIRECT` evita el proxy del sistema.
/// - `badCertificateCallback` siempre false.
/// - Para `*.rf-village-mx.com` se exige SHA-256 del certificado hoja.
///
/// Pins extraídos 2026-10-31 (wildcard `*.rf-village-mx.com`, cadena YE1 / ISRG X2).
/// Si Let's Encrypt rota la hoja, actualizar [_leafDerSha256Hex] y el pin-set XML.
class TlsPinning {
  TlsPinning._();

  static const pinnedDomainSuffix = 'rf-village-mx.com';

  /// SHA-256 hex del DER de la hoja actual (`CN=rf-village-mx.com`).
  static const leafDerSha256Hex = {
    'afc0a8a8650f50a6e81a7f7243a18973aab1c35d39cbbf5837bc52ad82e40f93',
  };

  /// SPKI SHA-256 base64 (Android `pin-set` y documentación).
  static const spkiSha256Base64 = [
    // hoja
    'VUwGnQVqxR8x/NGJqYOufLnpjwBR3B6RCI2AsBduMXQ=',
    // Let's Encrypt YE1
    'brzvtCELCIZUo4sD/qPX0ccRtPsd3DY6RfmxpOU9oB4=',
    // ISRG Root X2
    'diGVwiVYbubAI3RW4hB9xU8e/CH2GnkuvVFZE8zmgzI=',
  ];

  static bool isPinnedHost(String host) {
    final h = host.toLowerCase().trim();
    return h == pinnedDomainSuffix || h.endsWith('.$pinnedDomainSuffix');
  }

  /// Extra check after system TLS. Hosts fuera de RF Village no se pinnean
  /// (Dio no habla con MapLibre; esos van por el stack nativo).
  static bool allows({required String host, required List<int> der}) {
    if (!isPinnedHost(host)) return true;
    if (der.isEmpty) return false;
    final digest = sha256.convert(der).toString();
    return leafDerSha256Hex.contains(digest);
  }
}
