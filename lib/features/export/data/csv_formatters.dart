import 'package:intl/intl.dart';

import '../../../core/db/database.dart';
import '../../scanning/data/rf_scanners_bridge.dart';

class CsvEscaper {
  static String escape(Object? value) {
    final text = value?.toString() ?? '';
    final needsQuotes =
        text.contains(',') || text.contains('"') || text.contains('\n') || text.contains('\r');
    final escaped = text.replaceAll('"', '""');
    return needsQuotes ? '"$escaped"' : escaped;
  }
}

class CsvDecimalFormatter {
  static String latitude(double? value) =>
      _decimal(value, decimalPlaces: 7, maxIntegerDigits: 2);

  static String longitude(double? value) =>
      _decimal(value, decimalPlaces: 7, maxIntegerDigits: 3);

  static String measurement(num? value) =>
      _decimal(value?.toDouble(), decimalPlaces: 2, maxIntegerDigits: 8);

  static String mhz(double? value) =>
      _decimal(value, decimalPlaces: 1, maxIntegerDigits: 4);

  static String _decimal(
    double? value, {
    required int decimalPlaces,
    required int maxIntegerDigits,
  }) {
    if (value == null || value.isNaN || value.isInfinite) return '';
    final formatted = value.toStringAsFixed(decimalPlaces);
    final integerPart = formatted.split('.').first.replaceFirst('-', '');
    final digits = integerPart.replaceFirst(RegExp(r'^0+'), '');
    final count = digits.isEmpty ? 1 : digits.length;
    if (count > maxIntegerDigits) return '';
    return formatted;
  }
}

/// Export helpers: invalid GPS / infeasible RF → platform skip coords (0,0).
class CsvExportCoords {
  static const zeroLat = '0.0000000';
  static const zeroLon = '0.0000000';

  /// LTE TAC/CI "all ones" sentinels (also filtered in Kotlin; kept for re-export).
  static const lacUnavailableSentinel = 65535;
  static const cellIdUnavailableSentinel = 268435455;

  static bool isValidGps(double? latitude, double? longitude) {
    if (latitude == null || longitude == null) return false;
    if (latitude.isNaN || longitude.isNaN) return false;
    if (latitude.isInfinite || longitude.isInfinite) return false;
    return true;
  }

  static bool isZeroMccMnc(String? value) {
    if (value == null) return true;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return true;
    return int.tryParse(trimmed) == 0;
  }

  static bool isFeasibleLte(LteSample sample) {
    if (isZeroMccMnc(sample.mcc) || isZeroMccMnc(sample.mnc)) return false;
    final cellId = sample.cellId;
    if (cellId == null || cellId == cellIdUnavailableSentinel) return false;
    final lac = sample.lac;
    if (lac == null || lac == lacUnavailableSentinel) return false;
    return true;
  }

  static bool isFeasibleWifiBle(WifiBleSample sample) {
    return sample.mac.trim().isNotEmpty;
  }

  /// Returns `(latitude, longitude)` CSV strings; zeros when GPS missing or RF bad.
  static (String lat, String lon) forWifiBle(WifiBleSample sample) {
    if (!isFeasibleWifiBle(sample) ||
        !isValidGps(sample.latitude, sample.longitude)) {
      return (zeroLat, zeroLon);
    }
    return (
      CsvDecimalFormatter.latitude(sample.latitude),
      CsvDecimalFormatter.longitude(sample.longitude),
    );
  }

  static (String lat, String lon) forLte(LteSample sample) {
    if (!isFeasibleLte(sample) ||
        !isValidGps(sample.latitude, sample.longitude)) {
      return (zeroLat, zeroLon);
    }
    return (
      CsvDecimalFormatter.latitude(sample.latitude),
      CsvDecimalFormatter.longitude(sample.longitude),
    );
  }
}

class WigleCsvFormatter {
  static const header =
      'MAC,SSID,AuthMode,FirstSeen,Channel,RSSI,CurrentLatitude,CurrentLongitude,AltitudeMeters,AccuracyMeters,Type';

  final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  String format(List<WifiBleSample> samples, {int sessionStartedAt = 0}) {
    final buffer = StringBuffer()..writeln(header);
    for (final sample in samples) {
      final ts = sample.timestamp > sessionStartedAt
          ? sample.timestamp
          : sessionStartedAt;
      final firstSeen = _dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(ts, isUtc: false),
      );
      final (lat, lon) = CsvExportCoords.forWifiBle(sample);
      buffer.writeln(
        [
          sample.mac,
          sample.ssid,
          sample.authMode,
          firstSeen,
          sample.channel,
          sample.rssi,
          lat,
          lon,
          CsvDecimalFormatter.measurement(sample.altitudeMeters),
          CsvDecimalFormatter.measurement(sample.accuracyMeters),
          sample.type,
        ].map(CsvEscaper.escape).join(','),
      );
    }
    return buffer.toString();
  }
}

class LteCsvFormatter {
  LteCsvFormatter({LteBandMapper? bandMapper})
      : _bandMapper = bandMapper ?? LteBandMapper();

  static const header =
      'Timestamp,Tecnología,TipoCelda,Estado,MCC,MNC,LAC,CellID,eNodeB,Sector,PCI,Banda,EARFCN,FreqDL_MHz,FreqUL_MHz,RSSI,RSRP,RSRQ,SINR,Operador,Longitud,Latitud';

  final LteBandMapper _bandMapper;
  final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  String format(List<LteSample> samples, {int sessionStartedAt = 0}) {
    final buffer = StringBuffer()..writeln(header);
    for (final sample in samples) {
      final cellId = sample.cellId;
      final earfcn = sample.earfcn;
      final ts = sample.timestamp > sessionStartedAt
          ? sample.timestamp
          : sessionStartedAt;
      final (lat, lon) = CsvExportCoords.forLte(sample);
      buffer.writeln(
        [
          _dateFormat.format(
            DateTime.fromMillisecondsSinceEpoch(ts, isUtc: false),
          ),
          sample.technology,
          'LTE',
          sample.state,
          sample.mcc,
          sample.mnc,
          sample.lac,
          cellId,
          cellId == null ? null : cellId ~/ 256,
          cellId == null ? null : cellId % 256,
          sample.pci,
          sample.band ?? _bandMapper.bandFromEarfcn(earfcn),
          earfcn,
          CsvDecimalFormatter.mhz(_bandMapper.downlinkMhzFromEarfcn(earfcn)),
          CsvDecimalFormatter.mhz(_bandMapper.uplinkMhzFromEarfcn(earfcn)),
          sample.rssi,
          sample.rsrp,
          sample.rsrq,
          sample.sinr,
          sample.operatorName,
          lon,
          lat,
        ].map(CsvEscaper.escape).join(','),
      );
    }
    return buffer.toString();
  }
}
