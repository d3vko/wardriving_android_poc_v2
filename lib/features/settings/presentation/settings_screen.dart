import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../../scanning/domain/wardriving_repository.dart';
import '../data/app_settings_store.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Intervalo de muestreo'),
            subtitle: Text('${settings.sampleIntervalMillis ~/ 1000} s'),
            trailing: SizedBox(
              width: 160,
              child: Slider(
                min: 5,
                max: 60,
                divisions: 11,
                value: (settings.sampleIntervalMillis / 1000).clamp(5, 60),
                label: '${settings.sampleIntervalMillis ~/ 1000}s',
                onChanged: (v) {
                  controller.update(
                    (s) => s.copyWith(sampleIntervalMillis: (v.round() * 1000)),
                  );
                },
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Wi‑Fi'),
            value: settings.wifiEnabled,
            onChanged: (v) => controller.update((s) => s.copyWith(wifiEnabled: v)),
          ),
          SwitchListTile(
            title: const Text('BLE'),
            value: settings.bleEnabled,
            onChanged: (v) => controller.update((s) => s.copyWith(bleEnabled: v)),
          ),
          SwitchListTile(
            title: const Text('LTE'),
            value: settings.lteEnabled,
            onChanged: (v) => controller.update((s) => s.copyWith(lteEnabled: v)),
          ),
          SwitchListTile(
            title: const Text('Upload tras sesión'),
            value: settings.uploadAfterSession,
            onChanged: (v) =>
                controller.update((s) => s.copyWith(uploadAfterSession: v)),
          ),
          SwitchListTile(
            title: const Text('Export CSV local'),
            value: settings.localCsvExport,
            onChanged: (v) =>
                controller.update((s) => s.copyWith(localCsvExport: v)),
          ),
          SwitchListTile(
            title: const Text('Keep screen awake'),
            value: settings.keepScreenAwake,
            onChanged: (v) =>
                controller.update((s) => s.copyWith(keepScreenAwake: v)),
          ),
          const Divider(),
          ListTile(
            title: const Text('Borrar datos locales'),
            subtitle: const Text('Sesiones, muestras y pendientes'),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('¿Borrar todo?'),
                  content: const Text(
                    'Se eliminarán sesiones, muestras y archivos de export.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Borrar'),
                    ),
                  ],
                ),
              );
              if (ok == true) {
                await ref.read(wardrivingRepositoryProvider).deleteAllLocalData();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos locales borrados')),
                  );
                }
              }
            },
          ),
          ListTile(
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.logout),
            onTap: () async {
              await ref.read(authStateProvider.notifier).logout();
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Gap v1: anonimizar SSID/BLE no implementado',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
