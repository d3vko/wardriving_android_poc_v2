import 'package:flutter/services.dart';

/// Puentes nativos Wi‑Fi / LTE — docs/NATIVE_BRIDGES.md.
class RfScannersBridge {
  static const channel = MethodChannel('com.d3vk0.wardriving/rf_scanners');

  Future<bool> wifiStartScan() async {
    final result = await channel.invokeMethod<bool>('wifi.startScan');
    return result ?? false;
  }

  Future<List<Map<String, dynamic>>> wifiGetScanResults() async {
    final result = await channel.invokeMethod<List<dynamic>>('wifi.getScanResults');
    return _asMapList(result);
  }

  Future<List<Map<String, dynamic>>> telephonyGetCellInfo() async {
    final result =
        await channel.invokeMethod<List<dynamic>>('telephony.getCellInfo');
    return _asMapList(result);
  }

  List<Map<String, dynamic>> _asMapList(List<dynamic>? result) {
    if (result == null) return [];
    return result.map((e) {
      if (e is Map<String, dynamic>) return e;
      if (e is Map) return Map<String, dynamic>.from(e);
      return <String, dynamic>{};
    }).toList();
  }
}

/// Dedupe 20s — port de DuplicateFilter.kt
class DuplicateFilter {
  DuplicateFilter({this.windowMillis = 20000});

  final int windowMillis;
  final Map<String, int> _lastSeen = {};

  bool shouldKeep(String key, int timestamp) {
    final previous = _lastSeen[key];
    if (previous != null && timestamp - previous < windowMillis) return false;
    _lastSeen[key] = timestamp;
    if (_lastSeen.length > 2000) {
      final cutoff = timestamp - windowMillis * 3;
      _lastSeen.removeWhere((_, value) => value < cutoff);
    }
    return true;
  }

  void clear() => _lastSeen.clear();
}

/// Port LteBandMapper.kt
class LteBandMapper {
  String? bandFromEarfcn(int? earfcn) => _specForEarfcn(earfcn)?.band;

  double? downlinkMhzFromEarfcn(int? earfcn) {
    final value = earfcn;
    if (value == null) return null;
    final spec = _specForEarfcn(value);
    if (spec == null) return null;
    return spec.downlinkLowMhz + 0.1 * (value - spec.downlinkOffset);
  }

  double? uplinkMhzFromEarfcn(int? earfcn) {
    final value = earfcn;
    if (value == null) return null;
    final spec = _specForEarfcn(value);
    if (spec == null) return null;
    return spec.uplinkLowMhz + 0.1 * (value - spec.downlinkOffset);
  }

  _BandSpec? _specForEarfcn(int? earfcn) {
    if (earfcn == null) return null;
    for (final spec in _bandSpecs) {
      if (earfcn >= spec.downlinkStart && earfcn <= spec.downlinkEnd) {
        return spec;
      }
    }
    return null;
  }

  static const _bandSpecs = [
    _BandSpec('1', 0, 599, 0, 2110.0, 1920.0),
    _BandSpec('2', 600, 1199, 600, 1930.0, 1850.0),
    _BandSpec('3', 1200, 1949, 1200, 1805.0, 1710.0),
    _BandSpec('4', 1950, 2399, 1950, 2110.0, 1710.0),
    _BandSpec('5', 2400, 2649, 2400, 869.0, 824.0),
    _BandSpec('7', 2750, 3449, 2750, 2620.0, 2500.0),
    _BandSpec('8', 3450, 3799, 3450, 925.0, 880.0),
    _BandSpec('20', 6150, 6449, 6150, 791.0, 832.0),
    _BandSpec('28', 9210, 9659, 9210, 758.0, 703.0),
  ];
}

class _BandSpec {
  const _BandSpec(
    this.band,
    this.downlinkStart,
    this.downlinkEnd,
    this.downlinkOffset,
    this.downlinkLowMhz,
    this.uplinkLowMhz,
  );

  final String band;
  final int downlinkStart;
  final int downlinkEnd;
  final int downlinkOffset;
  final double downlinkLowMhz;
  final double uplinkLowMhz;
}

int frequencyToChannel(int frequencyMhz) {
  if (frequencyMhz == 2484) return 14;
  if (frequencyMhz >= 2412 && frequencyMhz <= 2472) {
    return ((frequencyMhz - 2412) ~/ 5) + 1;
  }
  if (frequencyMhz >= 5180 && frequencyMhz <= 5885) {
    return (frequencyMhz - 5000) ~/ 5;
  }
  if (frequencyMhz >= 5955 && frequencyMhz <= 7115) {
    return (frequencyMhz - 5950) ~/ 5;
  }
  return 0;
}
