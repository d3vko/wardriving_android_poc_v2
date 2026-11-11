import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../config/env.dart';

/// Claves que no deben salir hacia errors-handler (tokens, passwords, GPS).
const _secretKeys = {
  'password',
  'password_confirm',
  'authorization',
  'access',
  'refresh',
  'jwt',
  'token',
  'cookie',
  'set-cookie',
  'dsn',
};

const _locationKeys = {
  'lat',
  'latitude',
  'lon',
  'lng',
  'longitude',
  'altitude',
  'altitudemeters',
  'accuracy',
  'accuracymeters',
  'bearing',
  'heading',
  'speed',
  'coordinates',
  'gps',
  'location',
  'geolocation',
  'position',
};

bool _isSensitiveKey(String key) {
  final normalized = key.toLowerCase().replaceAll(RegExp(r'[_-]'), '');
  if (_secretKeys.contains(key.toLowerCase()) ||
      _secretKeys.contains(normalized)) {
    return true;
  }
  return _locationKeys.contains(key.toLowerCase()) ||
      _locationKeys.contains(normalized);
}

/// Redacta mapas anidados. Usado por Sentry y por tests.
Map<String, dynamic> redactSensitiveMap(Map<dynamic, dynamic> input) {
  final out = <String, dynamic>{};
  input.forEach((key, value) {
    final name = key.toString();
    if (_isSensitiveKey(name)) {
      out[name] = '[redacted]';
      return;
    }
    if (value is Map) {
      out[name] = redactSensitiveMap(value);
    } else if (value is Iterable && value is! String) {
      out[name] = value.map((item) {
        if (item is Map) return redactSensitiveMap(item);
        return item;
      }).toList();
    } else {
      out[name] = value;
    }
  });
  return out;
}

SentryRequest _scrubRequest(SentryRequest request) {
  final headers = redactSensitiveMap(request.headers)
      .map((key, value) => MapEntry(key, '$value'));
  final raw = request.data;
  return SentryRequest.fromJson({
    if (request.url != null) 'url': request.url,
    if (request.method != null) 'method': request.method,
    if (request.queryString != null) 'query_string': request.queryString,
    if (request.cookies != null) 'cookies': '[redacted]',
    if (request.fragment != null) 'fragment': request.fragment,
    if (request.apiTarget != null) 'api_target': request.apiTarget,
    if (raw is Map) 'data': redactSensitiveMap(raw),
    if (headers.isNotEmpty) 'headers': headers,
  });
}

/// Filtra el evento antes de enviarlo al Sentry self-hosted.
SentryEvent? scrubSentryEvent(SentryEvent event, Hint hint) {
  event.user = null;
  final request = event.request;
  if (request != null) {
    event.request = _scrubRequest(request);
  }
  final crumbs = event.breadcrumbs;
  if (crumbs != null) {
    for (final crumb in crumbs) {
      scrubBreadcrumb(crumb, hint);
    }
  }
  return event;
}

Breadcrumb? scrubBreadcrumb(Breadcrumb? breadcrumb, Hint hint) {
  if (breadcrumb == null) return null;
  final data = breadcrumb.data;
  if (data != null && data.isNotEmpty) {
    breadcrumb.data = redactSensitiveMap(data);
  }
  return breadcrumb;
}

class CrashReporting {
  CrashReporting._();

  /// Rutas de auth cuyo 4xx es flujo de producto (credenciales, validación),
  /// no un fallo del sistema. Deben quedar breadcrumb pero no exception.
  static const _authPathMarkers = ['auth/login', 'auth/register', 'auth/password'];

  /// Decide si un error HTTP merece captureException en GlitchTip.
  /// 401/403 siempre son flujo de auth; 4xx en rutas auth también.
  @visibleForTesting
  static bool shouldCaptureHttpError(String path, int? statusCode) {
    if (statusCode == null) return true;
    if (statusCode == 401 || statusCode == 403) return false;
    final isAuthPath = _authPathMarkers.any(path.contains);
    if (isAuthPath && statusCode >= 400 && statusCode < 500) return false;
    return true;
  }

  static void configureOptions(SentryFlutterOptions options) {
    options.dsn = Env.sentryDsn;
    options.environment = kReleaseMode ? 'production' : 'debug';
    options.release = Env.releaseName;
    options.dist = Env.versionCode;
    options.sendDefaultPii = false;
    options.attachScreenshot = false;
    options.tracesSampleRate = 0;
    options.replay.sessionSampleRate = 0;
    options.replay.onErrorSampleRate = 0;
    options.beforeSend = scrubSentryEvent;
    options.beforeBreadcrumb = scrubBreadcrumb;
    options.diagnosticLevel = SentryLevel.warning;
  }

  static void applyStartupScope() {
    if (!Sentry.isEnabled) return;
    final host = Uri.tryParse(Env.baseUrl)?.host ?? 'unknown';
    Sentry.configureScope((scope) {
      scope.setTag('api_host', host);
      scope.setTag('app_version', Env.versionName);
      scope.setContexts('wardriving', {
        'api_host': host,
        'release': Env.releaseName,
      });
    });
  }

  static void recordHttpError(DioException error) {
    if (!Sentry.isEnabled) return;
    final uri = error.requestOptions.uri;
    final path = uri.path;
    final status = error.response?.statusCode;
    Sentry.addBreadcrumb(
      Breadcrumb.http(
        url: uri.replace(query: '', fragment: ''),
        method: error.requestOptions.method,
        statusCode: status,
        reason: error.type.name,
      ),
    );
    // 401/403 y 4xx de auth son flujo de producto, no crash.
    if (!shouldCaptureHttpError(path, status)) return;
    Sentry.captureException(
      error,
      stackTrace: error.stackTrace,
      withScope: (scope) {
        scope.setTag('http.status', '${status ?? 'none'}');
        scope.setTag('http.path', path);
      },
    );
  }
}
