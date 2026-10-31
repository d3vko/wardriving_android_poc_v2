import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'jwt_claims.dart';

class AuthTokenStore {
  AuthTokenStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'jwt';
  static const _usernameKey = 'jwt_username';

  final FlutterSecureStorage _storage;

  Future<String?> getToken() => _storage.read(key: _key);

  Future<String?> readUsername() async {
    final stored = await _storage.read(key: _usernameKey);
    if (stored != null && stored.trim().isNotEmpty) return stored.trim();
    return JwtClaims.username(await getToken());
  }

  Future<void> saveToken(String token) => saveSession(token: token);

  Future<void> saveSession({required String token, String? username}) async {
    await _storage.write(key: _key, value: token);
    final name = (username != null && username.trim().isNotEmpty)
        ? username.trim()
        : JwtClaims.username(token);
    if (name != null && name.isNotEmpty) {
      await _storage.write(key: _usernameKey, value: name);
    } else {
      await _storage.delete(key: _usernameKey);
    }
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
    await _storage.delete(key: _usernameKey);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
