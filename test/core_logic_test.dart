import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wardriving_rf_village_mx/core/network/api_client.dart';
import 'package:wardriving_rf_village_mx/features/export/data/csv_formatters.dart';
import 'package:wardriving_rf_village_mx/features/export/data/export_repository.dart';
import 'package:wardriving_rf_village_mx/features/scanning/data/rf_scanners_bridge.dart';
import 'package:wardriving_rf_village_mx/core/db/database.dart';

void main() {
  group('DuplicateFilter', () {
    test('keeps first and drops within window', () {
      final filter = DuplicateFilter(windowMillis: 20000);
      expect(filter.shouldKeep('wifi:aa', 1000), isTrue);
      expect(filter.shouldKeep('wifi:aa', 5000), isFalse);
      expect(filter.shouldKeep('wifi:aa', 22000), isTrue);
      expect(filter.shouldKeep('ble:bb', 22000), isTrue);
    });

    test('evicts when over capacity', () {
      final filter = DuplicateFilter(windowMillis: 1000);
      for (var i = 0; i < 2100; i++) {
        filter.shouldKeep('k$i', i * 10);
      }
      expect(filter.shouldKeep('fresh', 100000), isTrue);
    });
  });

  group('LteBandMapper', () {
    final mapper = LteBandMapper();

    test('maps band 3 earfcn', () {
      expect(mapper.bandFromEarfcn(1850), '3');
      expect(mapper.downlinkMhzFromEarfcn(1850), closeTo(1870.0, 0.01));
    });

    test('null earfcn', () {
      expect(mapper.bandFromEarfcn(null), isNull);
      expect(mapper.downlinkMhzFromEarfcn(null), isNull);
    });
  });

  group('WigleCsvFormatter', () {
    test('emits header and row', () {
      final sample = WifiBleSample(
        id: 1,
        sessionId: 's1',
        timestamp: 1710000000000,
        type: 'WIFI',
        mac: 'aa:bb:cc:dd:ee:ff',
        ssid: 'Test,Net',
        authMode: '[WPA2]',
        channel: '6',
        rssi: -67,
        latitude: 1.2345678,
        longitude: -9.8765432,
        altitudeMeters: 100,
        accuracyMeters: 5,
        rawPayload: null,
      );
      final csv = WigleCsvFormatter().format([sample]);
      expect(csv, startsWith(WigleCsvFormatter.header));
      expect(csv, contains('"Test,Net"'));
      expect(csv, contains('WIFI'));
      expect(csv, contains('1.2345678'));
      expect(csv, contains('-9.8765432'));
    });

    test('writes zero coords when GPS missing', () {
      final sample = WifiBleSample(
        id: 1,
        sessionId: 's1',
        timestamp: 1710000000000,
        type: 'BLE',
        mac: '11:22:33:44:55:66',
        ssid: '',
        authMode: 'BLE',
        channel: '',
        rssi: -80,
      );
      final csv = WigleCsvFormatter().format([sample]);
      expect(csv, contains('0.0000000,0.0000000'));
    });

    test('writes zero coords when MAC empty', () {
      final sample = WifiBleSample(
        id: 1,
        sessionId: 's1',
        timestamp: 1710000000000,
        type: 'WIFI',
        mac: '',
        ssid: 'x',
        authMode: '[OPEN]',
        channel: '1',
        rssi: -50,
        latitude: 1.2,
        longitude: -9.8,
      );
      final csv = WigleCsvFormatter().format([sample]);
      expect(csv, contains('0.0000000,0.0000000'));
    });
  });

  group('LteCsvFormatter', () {
    LteSample validLte({
      int timestamp = 1710000000000,
      String? mcc = '334',
      String? mnc = '20',
      int? lac = 577,
      int? cellId = 23073557,
      double? latitude = 1.2345678,
      double? longitude = -9.8765432,
    }) {
      return LteSample(
        id: 1,
        sessionId: 's1',
        timestamp: timestamp,
        technology: 'LTE',
        state: '1',
        mcc: mcc,
        mnc: mnc,
        lac: lac,
        cellId: cellId,
        pci: 123,
        earfcn: 1850,
        band: '3',
        rssi: -90,
        rsrp: -100,
        rsrq: -12,
        sinr: 5,
        operatorName: 'TELCEL',
        latitude: latitude,
        longitude: longitude,
      );
    }

    test('emits valid row with synthetic coords', () {
      final csv = LteCsvFormatter().format([validLte()]);
      expect(csv, startsWith(LteCsvFormatter.header));
      expect(csv, contains('334'));
      expect(csv, contains('1.2345678'));
      expect(csv, contains('-9.8765432'));
    });

    test('clamps timestamp below sessionStartedAt', () {
      const sessionStart = 1710000000000;
      final csv = LteCsvFormatter().format(
        [validLte(timestamp: 150000000)], // boot-like ms → 1970 if unclamped
        sessionStartedAt: sessionStart,
      );
      final expected = formatLocalTimestamp(sessionStart);
      expect(csv, contains(expected));
      expect(csv, isNot(contains('1970-')));
    });

    test('writes zero coords when GPS missing', () {
      final csv = LteCsvFormatter().format([
        validLte(latitude: null, longitude: null),
      ]);
      expect(csv, contains('0.0000000,0.0000000'));
    });

    test('writes zero coords when MCC/MNC are zero', () {
      final csv = LteCsvFormatter().format([
        validLte(mcc: '0', mnc: '0'),
      ]);
      expect(csv, contains('0.0000000,0.0000000'));
    });

    test('writes zero coords for CellID sentinel', () {
      final csv = LteCsvFormatter().format([
        validLte(cellId: CsvExportCoords.cellIdUnavailableSentinel),
      ]);
      expect(csv, contains('0.0000000,0.0000000'));
    });

    test('writes zero coords for LAC sentinel', () {
      final csv = LteCsvFormatter().format([
        validLte(lac: CsvExportCoords.lacUnavailableSentinel),
      ]);
      expect(csv, contains('0.0000000,0.0000000'));
    });
  });

  group('upload validation', () {
    test('requires HTTP 201 and matching hash', () {
      const hash = 'abc123';
      expect(
        () => validateUploadResponse(200, [
          const RemoteFileDto(hashSha256: hash, isProcessed: true),
        ], hash),
        throwsA(isA<UploadException>()),
      );

      final match = validateUploadResponse(201, [
        const RemoteFileDto(
          id: '1',
          hashSha256: 'ABC123',
          isProcessed: false,
        ),
      ], hash);
      expect(match.id, '1');
      expect(match.isProcessed, isFalse);
    });

    test('rejects missing hash match', () {
      expect(
        () => validateUploadResponse(201, [
          const RemoteFileDto(hashSha256: 'other', isProcessed: true),
        ], 'abc'),
        throwsA(isA<UploadException>()),
      );
    });
  });

  group('fileSha256', () {
    test('hashes file contents', () async {
      final file = File('${Directory.systemTemp.path}/wardriving_hash_test.csv')
        ..writeAsStringSync('hello');
      final digest = await fileSha256(file);
      expect(digest, isNotEmpty);
      expect(digest.length, 64);
      await file.delete();
    });
  });

  group('CsvEscaper', () {
    test('quotes commas', () {
      expect(CsvEscaper.escape('a,b'), '"a,b"');
      expect(CsvEscaper.escape('plain'), 'plain');
    });
  });
}

/// Local wall-clock formatting matching CSV formatters (`isUtc: false`).
String formatLocalTimestamp(int epochMs) {
  final dt = DateTime.fromMillisecondsSinceEpoch(epochMs, isUtc: false);
  String two(int n) => n.toString().padLeft(2, '0');
  return '${dt.year}-${two(dt.month)}-${two(dt.day)} '
      '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
}
