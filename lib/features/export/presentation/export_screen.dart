import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sessions/presentation/sessions_screen.dart';
import '../data/export_repository.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  String? _selectedSessionId;
  String? _message;
  bool _busy = false;
  bool _zip = true;
  List<File> _lastFiles = [];

  Future<void> _export() async {
    final id = _selectedSessionId;
    if (id == null) {
      setState(() => _message = 'Selecciona una sesión');
      return;
    }
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final result = await ref.read(exportRepositoryProvider).exportSession(
            id,
            zip: _zip,
          );
      _lastFiles = result.files;
      setState(() {
        _message = _lastFiles.isEmpty
            ? 'Sin muestras para exportar'
            : 'Exportado: ${_lastFiles.map((f) => f.uri.pathSegments.last).join(', ')}';
      });
    } catch (e) {
      setState(() => _message = '$e');
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionsAsync = ref.watch(sessionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sessionsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('$e'),
              data: (sessions) {
                return DropdownButtonFormField<String>(
                  initialValue: _selectedSessionId,
                  decoration: const InputDecoration(
                    labelText: 'Sesión',
                    border: OutlineInputBorder(),
                  ),
                  items: sessions
                      .map(
                        (s) => DropdownMenuItem(
                          value: s.id,
                          child: Text('${s.id.substring(0, 8)} · ${s.status}'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedSessionId = v),
                );
              },
            ),
            SwitchListTile(
              title: const Text('Empaquetar ZIP'),
              value: _zip,
              onChanged: (v) => setState(() => _zip = v),
            ),
            const Text(
              'device_source: wifi_ble_android | lte_android',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _busy ? null : _export,
              child: const Text('Generar CSV'),
            ),
            OutlinedButton(
              onPressed: _lastFiles.isEmpty
                  ? null
                  : () => ref.read(exportRepositoryProvider).shareFiles(_lastFiles),
              child: const Text('Compartir'),
            ),
            OutlinedButton(
              onPressed: _lastFiles.isEmpty
                  ? null
                  : () => ref
                      .read(exportRepositoryProvider)
                      .saveAs(_lastFiles.first),
              child: const Text('Guardar como…'),
            ),
            if (_message != null) ...[
              const SizedBox(height: 16),
              Text(_message!),
            ],
          ],
        ),
      ),
    );
  }
}
