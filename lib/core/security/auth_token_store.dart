import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStore {
  AuthTokenStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'jwt';

  final FlutterSecureStorage _storage;

  Future<String?> getToken() => _storage.read(key: _key);

  Future<void> saveToken(String token) => _storage.write(key: _key, value: token);

  Future<void> clear() => _storage.delete(key: _key);

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
