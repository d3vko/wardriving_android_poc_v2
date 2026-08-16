import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/db/database.dart';
import '../../../core/models/models.dart';
import '../../export/data/export_repository.dart';
import '../../scanning/domain/wardriving_repository.dart';
import '../../settings/data/app_settings_store.dart';

final sessionsProvider = StreamProvider<List<WardrivingSession>>((ref) {
  return ref.watch(wardrivingRepositoryProvider).observeSessions();
});

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsProvider);
    ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        actions: [
          PopupMenuButton<SessionFilter>(
            initialValue: ref.read(appSettingsStoreProvider).readSessionFilter(),
            onSelected: (f) async {
              await ref.read(settingsControllerProvider.notifier).setFilter(f);
              ref.invalidate(sessionsProvider);
            },
            itemBuilder: (_) => SessionFilter.values
                .map(
                  (f) => PopupMenuItem(value: f, child: Text(f.label)),
                )
                .toList(),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (sessions) {
          final currentFilter =
              ref.read(appSettingsStoreProvider).readSessionFilter();
          final filtered = sessions.where((s) {
            switch (currentFilter) {
              case SessionFilter.all:
                return true;
              case SessionFilter.processed:
                return s.uploaded;
              case SessionFilter.unprocessed:
                return !s.uploaded;
            }
          }).toList();
          if (filtered.isEmpty) {
            return const Center(child: Text('Sin sesiones'));
          }
          final fmt = DateFormat('yyyy-MM-dd HH:mm');
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final s = filtered[index];
              return ListTile(
                title: Text(s.id.substring(0, 8)),
                subtitle: Text(
                  '${fmt.format(DateTime.fromMillisecondsSinceEpoch(s.startedAt))} · ${s.status}'
                  '${s.uploaded ? ' · subida' : ''}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SessionDetailScreen(sessionId: s.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SessionDetailScreen extends ConsumerStatefulWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<SessionDetailScreen> createState() =>
      _SessionDetailScreenState();
}

class _SessionDetailScreenState extends ConsumerState<SessionDetailScreen> {
  String? _status;
  bool _busy = false;

  Future<void> _upload() async {
    setState(() {
      _busy = true;
      _status = 'Preparando…';
    });
    try {
      final exportRepo = ref.read(exportRepositoryProvider);
      await exportRepo.enqueueExportsForUpload(widget.sessionId);
      final uploadRepo = ref.read(uploadRepositoryProvider);
      final results = await uploadRepo.uploadSessionPending(widget.sessionId);
      final ok = results.whereType<UploadSuccess>().length;
      final fail = results.whereType<UploadFailure>().length;
      setState(() => _status = 'OK: $ok · Error: $fail');
    } catch (e) {
      setState(() => _status = '$e');
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(wardrivingRepositoryProvider).getSession(widget.sessionId),
      builder: (context, snapshot) {
        final session = snapshot.data;
        return Scaffold(
          appBar: AppBar(title: Text(widget.sessionId.substring(0, 8))),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Status: ${session?.status ?? '…'}'),
                Text('Uploaded: ${session?.uploaded ?? false}'),
                Text('Export: ${session?.localExportPath ?? '-'}'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _busy ? null : _upload,
                  child: const Text('Exportar y subir'),
                ),
                if (_status != null) ...[
                  const SizedBox(height: 12),
                  Text(_status!),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
