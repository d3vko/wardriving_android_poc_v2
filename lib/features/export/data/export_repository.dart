import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/db/database.dart';
import '../../../core/models/models.dart';
import '../../../core/network/api_client.dart';
import '../../scanning/domain/wardriving_repository.dart';
import 'csv_formatters.dart';

final exportRepositoryProvider = Provider<ExportRepository>((ref) {
  return ExportRepository(
    db: ref.watch(databaseProvider),
    repo: ref.watch(wardrivingRepositoryProvider),
    api: ref.watch(apiClientProvider),
    config: ref.watch(apiConfigProvider),
  );
});

final uploadRepositoryProvider = Provider<UploadRepository>((ref) {
  return UploadRepository(
    db: ref.watch(databaseProvider),
    api: ref.watch(apiClientProvider),
    config: ref.watch(apiConfigProvider),
  );
});

class ExportResult {
  const ExportResult({
    this.wifiBleFile,
    this.lteFile,
    this.zipFile,
  });

  final File? wifiBleFile;
  final File? lteFile;
  final File? zipFile;

  List<File> get files => [
        ?wifiBleFile,
        ?lteFile,
        ?zipFile,
      ];
}

class ExportRepository {
  ExportRepository({
    required this.db,
    required this.repo,
    required this.api,
    required this.config,
  });

  final WardrivingDatabase db;
  final WardrivingRepository repo;
  final ApiClient api;
  final ApiConfig config;

  Future<Directory> _exportsDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'exports'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<ExportResult> exportSession(
    String sessionId, {
    bool zip = false,
  }) async {
    final session = await repo.getSession(sessionId);
    if (session == null) throw StateError('Sesión no encontrada');

    final wifiBle = await repo.getWifiBleSamples(sessionId);
    final lte = await repo.getLteSamples(sessionId);
    final dir = await _exportsDir();
    final ts = DateTime.now().millisecondsSinceEpoch;
    File? wifiFile;
    File? lteFile;

    if (wifiBle.isNotEmpty) {
      final csv = WigleCsvFormatter().format(
        wifiBle,
        sessionStartedAt: session.startedAt,
      );
      wifiFile = File(p.join(dir.path, 'wifi_ble_${sessionId}_$ts.csv'));
      await wifiFile.writeAsString(csv);
    }
    if (lte.isNotEmpty) {
      final csv = LteCsvFormatter().format(
        lte,
        sessionStartedAt: session.startedAt,
      );
      lteFile = File(p.join(dir.path, 'lte_${sessionId}_$ts.csv'));
      await lteFile.writeAsString(csv);
    }

    File? zipFile;
    if (zip && (wifiFile != null || lteFile != null)) {
      zipFile = File(p.join(dir.path, 'session_${sessionId}_$ts.zip'));
      final encoder = ZipFileEncoder()..create(zipFile.path);
      if (wifiFile != null) encoder.addFile(wifiFile);
      if (lteFile != null) encoder.addFile(lteFile);
      encoder.close();
    }

    final paths = [
      if (wifiFile != null) wifiFile.path,
      if (lteFile != null) lteFile.path,
      if (zipFile != null) zipFile.path,
    ].join(';');
    if (paths.isNotEmpty) {
      await repo.markSessionExported(sessionId, paths);
    }

    return ExportResult(
      wifiBleFile: wifiFile,
      lteFile: lteFile,
      zipFile: zipFile,
    );
  }

  Future<void> shareFiles(List<File> files) async {
    if (files.isEmpty) return;
    await SharePlus.instance.share(
      ShareParams(files: files.map((f) => XFile(f.path)).toList()),
    );
  }

  Future<void> saveAs(File source) async {
    final bytes = await source.readAsBytes();
    await FilePicker.saveFile(
      fileName: p.basename(source.path),
      bytes: bytes,
    );
  }

  Future<void> enqueueExportsForUpload(String sessionId) async {
    final result = await exportSession(sessionId);
    final uploadRepo = UploadRepository(db: db, api: api, config: config);
    if (result.wifiBleFile != null) {
      final count = (await repo.getWifiBleSamples(sessionId)).length;
      await uploadRepo.enqueuePending(
        sessionId: sessionId,
        uploadType: config.wifiBleUploadType,
        file: result.wifiBleFile!,
        sampleCount: count,
      );
    }
    if (result.lteFile != null) {
      final count = (await repo.getLteSamples(sessionId)).length;
      await uploadRepo.enqueuePending(
        sessionId: sessionId,
        uploadType: config.lteUploadType,
        file: result.lteFile!,
        sampleCount: count,
      );
    }
  }
}

class UploadException implements Exception {
  UploadException(this.message, {this.actionable = true});
  final String message;
  final bool actionable;
  @override
  String toString() => message;
}

sealed class UploadAttemptResult {
  const UploadAttemptResult();
}

class UploadSuccess extends UploadAttemptResult {
  const UploadSuccess(this.pendingUploadId, this.isProcessed);
  final int pendingUploadId;
  final bool isProcessed;
}

class UploadFailure extends UploadAttemptResult {
  const UploadFailure(this.pendingUploadId, this.message);
  final int pendingUploadId;
  final String message;
}

class UploadRepository {
  UploadRepository({
    required this.db,
    required this.api,
    required this.config,
  });

  final WardrivingDatabase db;
  final ApiClient api;
  final ApiConfig config;

  Future<int> enqueuePending({
    required String sessionId,
    required String uploadType,
    required File file,
    required int sampleCount,
  }) async {
    if (sampleCount <= 0) throw StateError('Sin datos disponibles');
    final existing = await db.getPendingUploadByType(sessionId, uploadType);
    return db.upsertPendingUpload(
      PendingUploadsCompanion.insert(
        id: existing != null ? Value(existing.id) : const Value.absent(),
        sessionId: sessionId,
        uploadType: uploadType,
        filePath: file.absolute.path,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        sampleCount: sampleCount,
        remoteId: Value(existing?.remoteId),
        remoteSource: Value(existing?.remoteSource),
        remoteHashSha256: Value(existing?.remoteHashSha256),
        isProcessed: Value(existing?.isProcessed),
        responseReceivedAt: Value(existing?.responseReceivedAt),
      ),
    );
  }

  Future<bool> uploadPending(PendingUpload upload) async {
    final file = File(upload.filePath);
    if (!await file.exists()) {
      throw UploadException('CSV file no longer exists: ${upload.filePath}');
    }
    final localHash = await fileSha256(file);
    // ignore: avoid_print
    print(
      'Uploading file=${file.path} device_source=${upload.uploadType} '
      'to ${config.resolvedUploadUrl}',
    );
    final response = await api.uploadFiles(
      file: file,
      deviceSource: upload.uploadType,
    );
    final match = validateUploadResponse(response.statusCode, response.files, localHash);
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.markUploadAccepted(
      id: upload.id,
      remoteId: match.id,
      remoteSource: match.source,
      remoteHashSha256: match.hashSha256!,
      isProcessed: match.isProcessed!,
      receivedAt: now,
    );
    return match.isProcessed!;
  }

  Future<List<UploadAttemptResult>> uploadSessionPending(String sessionId) async {
    final pending = await db.getUploadablePending(sessionId);
    final results = <UploadAttemptResult>[];
    for (final upload in pending) {
      try {
        final processed = await uploadPending(upload);
        results.add(UploadSuccess(upload.id, processed));
      } catch (e) {
        final msg = e.toString();
        await db.markUploadFailed(upload.id, msg);
        results.add(UploadFailure(upload.id, msg));
      }
    }
    final uploads = await db.getSessionUploads(sessionId);
    await db.updateSessionUploaded(sessionId, uploads.isNotEmpty);
    return results;
  }

  Stream<List<PendingUpload>> observePending(String sessionId) =>
      db.observePendingUploads(sessionId);
}

RemoteFileDto? matchRemoteFile(String localSha256, List<RemoteFileDto> files) {
  return files.cast<RemoteFileDto?>().firstWhere(
        (f) => f?.hashSha256?.toLowerCase() == localSha256.toLowerCase(),
        orElse: () => null,
      );
}

RemoteFileDto validateUploadResponse(
  int statusCode,
  List<RemoteFileDto> files,
  String localSha256,
) {
  if (statusCode != 201) {
    throw UploadException(
      statusCode >= 200 && statusCode < 300
          ? 'se esperaba HTTP 201'
          : 'HTTP $statusCode',
    );
  }
  if (files.any((f) => f.hashSha256 == null || f.hashSha256!.isEmpty)) {
    throw UploadException('HTTP 201: hash_sha256 ausente en la respuesta');
  }
  if (files.any((f) => f.isProcessed == null)) {
    throw UploadException('HTTP 201: is_procesed ausente en la respuesta');
  }
  final match = matchRemoteFile(localSha256, files);
  if (match == null) {
    throw UploadException(
      'HTTP 201: ningún hash_sha256 coincide con el archivo enviado',
    );
  }
  return match;
}

Future<String> fileSha256(File file) async {
  final digest = await sha256.bind(file.openRead()).first;
  return digest.toString();
}
