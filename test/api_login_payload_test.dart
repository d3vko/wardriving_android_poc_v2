import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wardriving_rf_village_mx/core/models/models.dart';
import 'package:wardriving_rf_village_mx/core/network/api_client.dart';
import 'package:wardriving_rf_village_mx/core/security/auth_token_store.dart';

Map<String, dynamic>? _capturedBody;

class _RecordingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    _capturedBody = options.data as Map<String, dynamic>?;
    return ResponseBody.fromString(
      '{"access":"fake-access-token","username":"operator"}',
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeTokenStore extends AuthTokenStore {
  @override
  Future<String?> getToken() async => null;

  @override
  Future<void> saveSession({required String token, String? username}) async {}

  @override
  Future<bool> hasToken() async => false;

  @override
  Future<void> clear() async {}

  @override
  Future<String?> readUsername() async => null;

  @override
  Future<void> saveToken(String token) async {}
}

ApiClient _client() {
  final dio = Dio();
  dio.httpClientAdapter = _RecordingAdapter();
  return ApiClient(
    config: ApiConfig(
      baseUrl: 'https://example.com/wardriving/api/v1/',
      loginPath: 'auth/login/',
      registerPath: 'auth/register/',
      passwordRecoveryPath: 'auth/password/reset/',
      uploadPath: 'files-uploaded/',
      wifiBleUploadType: 'wifi_ble_android',
      lteUploadType: 'lte_android',
    ),
    tokenStore: _FakeTokenStore(),
    dio: dio,
  );
}

void main() {
  setUp(() => _capturedBody = null);

  test('login con username plano usa clave username', () async {
    await _client().login('operator', 'secret');
    expect(_capturedBody, {'username': 'operator', 'password': 'secret'});
    expect(_capturedBody!.containsKey('email'), isFalse);
  });

  test('login con email también usa clave username', () async {
    await _client().login('ops@example.com', 'secret');
    expect(_capturedBody, {'username': 'ops@example.com', 'password': 'secret'});
    expect(_capturedBody!.containsKey('email'), isFalse);
  });
}
