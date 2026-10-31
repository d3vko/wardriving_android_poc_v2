/// Modelos de dominio — paridad con core/domain/Models.kt.
library;

enum SessionStatus { running, paused, stopped }

enum SampleType { wifi, ble }

enum MapPinType { wifi, ble, lte }

enum SessionFilter {
  all('Todas'),
  processed('En plataforma'),
  unprocessed('Solo local');

  const SessionFilter(this.label);
  final String label;

  static SessionFilter fromStorage(String? value) {
    return SessionFilter.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SessionFilter.all,
    );
  }
}

class GeoLocation {
  const GeoLocation({
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.altitudeMeters,
    this.accuracyMeters,
    this.speedMetersPerSecond,
    this.bearingDegrees,
  });

  final int timestamp;
  final double latitude;
  final double longitude;
  final double? altitudeMeters;
  final double? accuracyMeters;
  final double? speedMetersPerSecond;
  final double? bearingDegrees;
}

class SessionSettings {
  const SessionSettings({
    this.sampleIntervalMillis = 2000,
    this.wifiEnabled = true,
    this.bleEnabled = true,
    this.lteEnabled = true,
    this.uploadAfterSession = false,
    this.localCsvExport = true,
    this.keepScreenAwake = false,
  });

  final int sampleIntervalMillis;
  final bool wifiEnabled;
  final bool bleEnabled;
  final bool lteEnabled;
  final bool uploadAfterSession;
  final bool localCsvExport;
  final bool keepScreenAwake;

  SessionSettings copyWith({
    int? sampleIntervalMillis,
    bool? wifiEnabled,
    bool? bleEnabled,
    bool? lteEnabled,
    bool? uploadAfterSession,
    bool? localCsvExport,
    bool? keepScreenAwake,
  }) {
    return SessionSettings(
      sampleIntervalMillis: sampleIntervalMillis ?? this.sampleIntervalMillis,
      wifiEnabled: wifiEnabled ?? this.wifiEnabled,
      bleEnabled: bleEnabled ?? this.bleEnabled,
      lteEnabled: lteEnabled ?? this.lteEnabled,
      uploadAfterSession: uploadAfterSession ?? this.uploadAfterSession,
      localCsvExport: localCsvExport ?? this.localCsvExport,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
    );
  }
}

class LiveCounters {
  const LiveCounters({
    this.wifiCount = 0,
    this.bleCount = 0,
    this.lteCount = 0,
    this.gpsStatus = 'Waiting',
    this.uploadStatus = 'Idle',
    this.sessionStatus = SessionStatus.stopped,
    this.sessionId,
    this.scanHint = '',
    this.wifiThrottled = false,
  });

  final int wifiCount;
  final int bleCount;
  final int lteCount;
  final String gpsStatus;
  final String uploadStatus;
  final SessionStatus sessionStatus;
  final String? sessionId;
  final String scanHint;
  final bool wifiThrottled;

  LiveCounters copyWith({
    int? wifiCount,
    int? bleCount,
    int? lteCount,
    String? gpsStatus,
    String? uploadStatus,
    SessionStatus? sessionStatus,
    String? sessionId,
    String? scanHint,
    bool? wifiThrottled,
  }) {
    return LiveCounters(
      wifiCount: wifiCount ?? this.wifiCount,
      bleCount: bleCount ?? this.bleCount,
      lteCount: lteCount ?? this.lteCount,
      gpsStatus: gpsStatus ?? this.gpsStatus,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      sessionStatus: sessionStatus ?? this.sessionStatus,
      sessionId: sessionId ?? this.sessionId,
      scanHint: scanHint ?? this.scanHint,
      wifiThrottled: wifiThrottled ?? this.wifiThrottled,
    );
  }
}

class MapPin {
  const MapPin({
    required this.id,
    required this.sessionId,
    required this.type,
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.rssiOrSignal,
  });

  final String id;
  final String sessionId;
  final MapPinType type;
  final String label;
  final double latitude;
  final double longitude;
  final int timestamp;
  final int? rssiOrSignal;
}

class ApiConfig {
  const ApiConfig({
    required this.baseUrl,
    required this.loginPath,
    required this.registerPath,
    required this.passwordRecoveryPath,
    required this.uploadPath,
    required this.wifiBleUploadType,
    required this.lteUploadType,
  });

  final String baseUrl;
  final String loginPath;
  final String registerPath;
  final String passwordRecoveryPath;
  final String uploadPath;
  final String wifiBleUploadType;
  final String lteUploadType;

  String resolveRelativeUrl(String path) {
    final normalizedBase = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    return normalizedBase + path.replaceFirst(RegExp(r'^/'), '');
  }

  String get resolvedUploadUrl => resolveRelativeUrl(uploadPath);
}
