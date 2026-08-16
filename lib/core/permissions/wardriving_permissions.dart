import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Paridad WardrivingPermissions v1.
class WardrivingPermissions {
  WardrivingPermissions._();

  static List<Permission> runtimePermissions() {
    final permissions = <Permission>[
      Permission.locationWhenInUse,
      Permission.phone,
    ];
    if (Platform.isAndroid) {
      permissions.addAll([
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.nearbyWifiDevices,
        Permission.notification,
      ]);
    }
    return permissions;
  }

  static Future<List<Permission>> missingRuntimePermissions() async {
    final missing = <Permission>[];
    for (final permission in runtimePermissions()) {
      final status = await permission.status;
      if (!status.isGranted) {
        // nearbyWifiDevices / notification may be unavailable on older APIs
        if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
          missing.add(permission);
        }
      }
    }
    return missing;
  }

  static Future<bool> hasRequiredRuntimePermissions() async {
    final missing = await missingRuntimePermissions();
    // Filter permissions that don't exist on this API level (treated as granted)
    for (final permission in missing) {
      final status = await permission.status;
      if (status.isGranted || status.isLimited) continue;
      // On older Android, nearbyWifiDevices may report denied incorrectly —
      // still request the core set.
      if (permission == Permission.nearbyWifiDevices ||
          permission == Permission.notification ||
          permission == Permission.bluetoothScan ||
          permission == Permission.bluetoothConnect) {
        // Request them but don't hard-fail if unsupported.
        continue;
      }
      return false;
    }
    // Always require location
    final location = await Permission.locationWhenInUse.status;
    return location.isGranted;
  }

  static Future<bool> requestAll() async {
    final statuses = await runtimePermissions().request();
    final location = statuses[Permission.locationWhenInUse];
    return location?.isGranted == true;
  }
}
