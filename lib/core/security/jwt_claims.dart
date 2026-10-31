import 'dart:convert';

/// Lee claims del JWT ya persistido. No verifica firma (el backend ya lo emitió).
class JwtClaims {
  JwtClaims._();

  static String? username(String? token) {
    final payload = decodePayload(token);
    if (payload == null) return null;
    for (final key in const ['username', 'preferred_username', 'user_name']) {
      final value = payload[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    final sub = payload['sub'];
    if (sub is String && sub.trim().isNotEmpty && !sub.contains('@')) {
      return sub.trim();
    }
    return null;
  }

  static Map<String, dynamic>? decodePayload(String? token) {
    if (token == null || token.isEmpty) return null;
    final parts = token.split('.');
    if (parts.length < 2) return null;
    try {
      var segment = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      final pad = segment.length % 4;
      if (pad != 0) {
        segment = segment.padRight(segment.length + (4 - pad), '=');
      }
      final json = utf8.decode(base64.decode(segment));
      final decoded = jsonDecode(json);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      return null;
    } catch (_) {
      return null;
    }
  }
}
