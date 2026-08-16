import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class WardrivingSessions extends Table {
  TextColumn get id => text()();
  IntColumn get startedAt => integer()();
  IntColumn get endedAt => integer().nullable()();
  TextColumn get status => text()();
  TextColumn get deviceSource => text()();
  TextColumn get notes => text().nullable()();
  BoolColumn get wifiEnabled => boolean()();
  BoolColumn get bleEnabled => boolean()();
  BoolColumn get lteEnabled => boolean()();
  BoolColumn get uploaded => boolean().withDefault(const Constant(false))();
  TextColumn get localExportPath => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocationSamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  IntColumn get timestamp => integer()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get altitudeMeters => real().nullable()();
  RealColumn get accuracyMeters => real().nullable()();
  RealColumn get speedMetersPerSecond => real().nullable()();
  RealColumn get bearingDegrees => real().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {sessionId, timestamp},
      ];
}

class WifiBleSamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  IntColumn get timestamp => integer()();
  TextColumn get type => text()();
  TextColumn get mac => text()();
  TextColumn get ssid => text()();
  TextColumn get authMode => text()();
  TextColumn get channel => text()();
  IntColumn get rssi => integer().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get altitudeMeters => real().nullable()();
  RealColumn get accuracyMeters => real().nullable()();
  TextColumn get rawPayload => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {sessionId, type, mac, timestamp},
      ];
}

class LteSamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  IntColumn get timestamp => integer()();
  TextColumn get technology => text()();
  TextColumn get state => text()();
  TextColumn get mcc => text().nullable()();
  TextColumn get mnc => text().nullable()();
  IntColumn get lac => integer().nullable()();
  IntColumn get cellId => integer().nullable()();
  IntColumn get pci => integer().nullable()();
  IntColumn get earfcn => integer().nullable()();
  TextColumn get band => text().nullable()();
  IntColumn get rssi => integer().nullable()();
  IntColumn get rsrp => integer().nullable()();
  IntColumn get rsrq => integer().nullable()();
  IntColumn get sinr => integer().nullable()();
  TextColumn get operatorName => text().named('operator').nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get latitude => real().nullable()();
  TextColumn get rawPayload => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {sessionId, timestamp, mcc, mnc, lac, cellId},
      ];
}

class PendingUploads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  TextColumn get uploadType => text()();
  TextColumn get filePath => text()();
  IntColumn get createdAt => integer()();
  IntColumn get sampleCount => integer()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get remoteSource => text().nullable()();
  TextColumn get remoteHashSha256 => text().nullable()();
  BoolColumn get isProcessed => boolean().nullable()();
  IntColumn get responseReceivedAt => integer().nullable()();
  IntColumn get uploadedAt => integer().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {sessionId, uploadType},
      ];
}

@DriftDatabase(
  tables: [
    WardrivingSessions,
    LocationSamples,
    WifiBleSamples,
    LteSamples,
    PendingUploads,
  ],
)
class WardrivingDatabase extends _$WardrivingDatabase {
  WardrivingDatabase() : super(_openConnection());

  WardrivingDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // --- Sessions ---

  Future<void> upsertSession(WardrivingSessionsCompanion session) {
    return into(wardrivingSessions).insertOnConflictUpdate(session);
  }

  Future<void> updateSessionStatus(
    String sessionId,
    String status,
    int? endedAt,
  ) {
    return (update(wardrivingSessions)..where((t) => t.id.equals(sessionId)))
        .write(
      WardrivingSessionsCompanion(
        status: Value(status),
        endedAt: Value(endedAt),
      ),
    );
  }

  Future<int> finishActiveSession(String sessionId, int endedAt) {
    return (update(wardrivingSessions)
          ..where(
            (t) =>
                t.id.equals(sessionId) &
                (t.status.equals('RUNNING') | t.status.equals('PAUSED')),
          ))
        .write(
      WardrivingSessionsCompanion(
        status: const Value('STOPPED'),
        endedAt: Value(endedAt),
      ),
    );
  }

  Future<void> updateSessionExport(
    String sessionId, {
    required bool uploaded,
    String? localExportPath,
  }) {
    return (update(wardrivingSessions)..where((t) => t.id.equals(sessionId)))
        .write(
      WardrivingSessionsCompanion(
        uploaded: Value(uploaded),
        localExportPath: Value(localExportPath),
      ),
    );
  }

  Future<void> updateSessionUploaded(String sessionId, bool uploaded) {
    return (update(wardrivingSessions)..where((t) => t.id.equals(sessionId)))
        .write(WardrivingSessionsCompanion(uploaded: Value(uploaded)));
  }

  Stream<List<WardrivingSession>> observeSessions() {
    return (select(wardrivingSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }

  Future<WardrivingSession?> getSession(String sessionId) {
    return (select(wardrivingSessions)..where((t) => t.id.equals(sessionId)))
        .getSingleOrNull();
  }

  Future<WardrivingSession?> getActiveSession() {
    return (select(wardrivingSessions)
          ..where(
            (t) => t.status.equals('RUNNING') | t.status.equals('PAUSED'),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<WardrivingSession>> getAllSessions() =>
      select(wardrivingSessions).get();

  // --- Samples ---

  Future<int> insertLocation(LocationSamplesCompanion sample) {
    return into(locationSamples).insert(
      sample,
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> insertWifiBle(List<WifiBleSamplesCompanion> samples) async {
    await batch((b) {
      b.insertAll(wifiBleSamples, samples, mode: InsertMode.insertOrIgnore);
    });
  }

  Future<void> insertLte(List<LteSamplesCompanion> samples) async {
    await batch((b) {
      b.insertAll(lteSamples, samples, mode: InsertMode.insertOrIgnore);
    });
  }

  Future<List<WifiBleSample>> getWifiBleSamples(String sessionId) {
    return (select(wifiBleSamples)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  Future<List<LteSample>> getLteSamples(String sessionId) {
    return (select(lteSamples)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  Stream<List<WifiBleSample>> observeGeolocatedWifiBle([String? sessionId]) {
    final query = select(wifiBleSamples)
      ..where(
        (t) =>
            t.latitude.isNotNull() &
            t.longitude.isNotNull() &
            (sessionId == null
                ? const Constant(true)
                : t.sessionId.equals(sessionId)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    return query.watch();
  }

  Stream<List<LteSample>> observeGeolocatedLte([String? sessionId]) {
    final query = select(lteSamples)
      ..where(
        (t) =>
            t.latitude.isNotNull() &
            t.longitude.isNotNull() &
            (sessionId == null
                ? const Constant(true)
                : t.sessionId.equals(sessionId)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    return query.watch();
  }

  Stream<int> observeWifiCount(String sessionId) {
    final count = wifiBleSamples.id.count();
    final query = selectOnly(wifiBleSamples)
      ..addColumns([count])
      ..where(
        wifiBleSamples.sessionId.equals(sessionId) &
            wifiBleSamples.type.equals('WIFI'),
      );
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Stream<int> observeBleCount(String sessionId) {
    final count = wifiBleSamples.id.count();
    final query = selectOnly(wifiBleSamples)
      ..addColumns([count])
      ..where(
        wifiBleSamples.sessionId.equals(sessionId) &
            wifiBleSamples.type.equals('BLE'),
      );
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Stream<int> observeLteCount(String sessionId) {
    final count = lteSamples.id.count();
    final query = selectOnly(lteSamples)
      ..addColumns([count])
      ..where(lteSamples.sessionId.equals(sessionId));
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Stream<LocationSample?> observeLatestLocation(String sessionId) {
    return (select(locationSamples)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(1))
        .watch()
        .map((rows) => rows.isEmpty ? null : rows.first);
  }

  // --- Pending uploads ---

  Future<int> upsertPendingUpload(PendingUploadsCompanion upload) {
    return into(pendingUploads).insertOnConflictUpdate(upload);
  }

  Future<PendingUpload?> getPendingUploadByType(
    String sessionId,
    String uploadType,
  ) {
    return (select(pendingUploads)
          ..where(
            (t) =>
                t.sessionId.equals(sessionId) & t.uploadType.equals(uploadType),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<PendingUpload?> getPendingUploadById(int id) {
    return (select(pendingUploads)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<PendingUpload>> getSessionUploads(String sessionId) {
    return (select(pendingUploads)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.uploadType)]))
        .get();
  }

  Stream<List<PendingUpload>> observePendingUploads(String sessionId) {
    return (select(pendingUploads)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.uploadType)]))
        .watch();
  }

  Future<List<PendingUpload>> getAllPendingUploads() =>
      select(pendingUploads).get();

  Future<List<PendingUpload>> getUploadablePending([String? sessionId]) async {
    final all = sessionId == null
        ? await select(pendingUploads).get()
        : await (select(pendingUploads)
              ..where((t) => t.sessionId.equals(sessionId)))
            .get();
    final processingSessions = all
        .where((u) => u.isProcessed == false)
        .map((u) => u.sessionId)
        .toSet();
    return all
        .where(
          (u) =>
              u.isProcessed == null && !processingSessions.contains(u.sessionId),
        )
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> markUploadFailed(int id, String error) async {
    final current = await getPendingUploadById(id);
    if (current == null) return;
    await (update(pendingUploads)..where((t) => t.id.equals(id))).write(
      PendingUploadsCompanion(
        retryCount: Value(current.retryCount + 1),
        lastError: Value(error),
      ),
    );
  }

  Future<void> markUploadAccepted({
    required int id,
    String? remoteId,
    String? remoteSource,
    required String remoteHashSha256,
    required bool isProcessed,
    required int receivedAt,
  }) {
    return (update(pendingUploads)..where((t) => t.id.equals(id))).write(
      PendingUploadsCompanion(
        remoteId: Value(remoteId),
        remoteSource: Value(remoteSource),
        remoteHashSha256: Value(remoteHashSha256),
        isProcessed: Value(isProcessed),
        responseReceivedAt: Value(receivedAt),
        uploadedAt: Value(receivedAt),
        lastError: const Value(null),
      ),
    );
  }

  Future<void> deletePendingUpload(int id) {
    return (delete(pendingUploads)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllLocalData() async {
    await delete(pendingUploads).go();
    await delete(lteSamples).go();
    await delete(wifiBleSamples).go();
    await delete(locationSamples).go();
    await delete(wardrivingSessions).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'wardriving.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

final databaseProvider = Provider<WardrivingDatabase>((ref) {
  final db = WardrivingDatabase();
  ref.onDispose(db.close);
  return db;
});
