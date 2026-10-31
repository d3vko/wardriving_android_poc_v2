import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/env.dart';
import '../models/models.dart';
import '../observability/crash_reporting.dart';
import '../security/auth_token_store.dart';
import '../security/tls_pinning.dart';

final authTokenStoreProvider = Provider<AuthTokenStore>((ref) => AuthTokenStore());

final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig(
    baseUrl: Env.baseUrl,
    loginPath: Env.loginPath,
    registerPath: Env.registerPath,
    passwordRecoveryPath: Env.passwordRecoveryPath,
    uploadPath: Env.uploadPath,
    wifiBleUploadType: Env.wifiBleUploadType,
    lteUploadType: Env.lteUploadType,
  );
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    config: ref.watch(apiConfigProvider),
    tokenStore: ref.watch(authTokenStoreProvider),
  );
});

class AuthResponse {
  const AuthResponse({this.refresh, this.access, this.username});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      refresh: json['refresh'] as String?,
      access: json['access'] as String?,
      username: json['username'] as String?,
    );
  }

  final String? refresh;
  final String? access;
  final String? username;
}

class RemoteFileDto {
  const RemoteFileDto({
    this.id,
    this.source,
    this.isProcessed,
    this.hashSha256,
  });

  factory RemoteFileDto.fromJson(Map<String, dynamic> json) {
    return RemoteFileDto(
      id: json['id']?.toString(),
      source: json['source'] as String?,
      isProcessed: json['is_procesed'] as bool?,
      hashSha256: json['hash_sha256'] as String?,
    );
  }

  final String? id;
  final String? source;
  final bool? isProcessed;
  final String? hashSha256;
}

class ApiClient {
  ApiClient({
    required this.config,
    required this.tokenStore,
    Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: config.baseUrl.endsWith('/')
                    ? config.baseUrl
                    : '${config.baseUrl}/',
                connectTimeout: const Duration(seconds: 30),
                receiveTimeout: const Duration(seconds: 60),
                headers: {'Content-Type': 'application/json'},
              ),
            ) {
    if (dio == null) {
      _hardenTls(this.dio);
    }
    this.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStore.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final code = error.response?.statusCode;
          if (code == 401 || code == 403) {
            await tokenStore.clear();
          }
          CrashReporting.recordHttpError(error);
          handler.next(error);
        },
      ),
    );
  }

  final ApiConfig config;
  final AuthTokenStore tokenStore;
  final Dio dio;

  static void _hardenTls(Dio dio) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.findProxy = (_) => 'DIRECT';
        client.badCertificateCallback = (cert, host, port) => false;
        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) return false;
        return TlsPinning.allows(host: host, der: cert.der);
      },
    );
  }

  Future<AuthResponse> login(String identifier, String password) async {
    final body = <String, dynamic>{
      'password': password,
      if (identifier.contains('@')) 'email': identifier else 'username': identifier,
    };
    final response = await dio.post<Map<String, dynamic>>(
      config.loginPath,
      data: body,
    );
    return AuthResponse.fromJson(response.data ?? {});
  }

  Future<AuthResponse> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      config.registerPath,
      data: {
        'username': username,
        'email': email,
        'password': password,
        'password_confirm': passwordConfirm,
      },
    );
    return AuthResponse.fromJson(response.data ?? {});
  }

  Future<void> recoverPassword(String identifier) async {
    final body = <String, dynamic>{
      if (identifier.contains('@')) 'email': identifier else 'username': identifier,
    };
    final response = await dio.post(config.passwordRecoveryPath, data: body);
    if (response.statusCode != null &&
        response.statusCode! >= 400) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Password recovery failed',
      );
    }
  }

  /// Upload multipart. Returns status code + parsed remote files.
  Future<({int statusCode, List<RemoteFileDto> files})> uploadFiles({
    required File file,
    required String deviceSource,
  }) async {
    final formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
      ),
      'device_source': deviceSource,
    });
    final response = await dio.post<dynamic>(
      config.uploadPath,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        validateStatus: (_) => true,
      ),
    );
    final files = <RemoteFileDto>[];
    final data = response.data;
    if (data is List) {
      for (final item in data) {
        if (item is Map<String, dynamic>) {
          files.add(RemoteFileDto.fromJson(item));
        } else if (item is Map) {
          files.add(RemoteFileDto.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    } else if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded is List) {
        for (final item in decoded) {
          if (item is Map) {
            files.add(RemoteFileDto.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
    }
    return (statusCode: response.statusCode ?? 0, files: files);
  }
}

String apiErrorMessage(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map) {
      for (final key in ['detail', 'message', 'error', 'non_field_errors']) {
        final value = data[key];
        if (value is String && value.isNotEmpty) return value;
        if (value is List && value.isNotEmpty) return value.first.toString();
      }
      final first = data.values.cast<dynamic>().firstWhere(
            (v) => v is String || (v is List && v.isNotEmpty),
            orElse: () => null,
          );
      if (first is String) return first;
      if (first is List && first.isNotEmpty) return first.first.toString();
    }
    return error.message ?? 'Error de red';
  }
  return error.toString();
}
