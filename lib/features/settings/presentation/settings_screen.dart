import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/brand.dart';
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
            leading: Image.asset(Brand.villageMark, width: 36, height: 36),
            title: const Text('Intervalo Wi‑Fi / LTE'),
            subtitle: Text(
              '${settings.sampleIntervalMillis ~/ 1000} s · BLE va continuo. 1 s rápido, 2 s campo, 3 s quieto (Wigle).',
            ),
            trailing: SizedBox(
              width: 160,
              child: Slider(
                min: 1,
                max: 10,
                divisions: 9,
                value: (settings.sampleIntervalMillis / 1000).clamp(1, 10),
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
          _AuthSettingsTile(),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: CreditLine(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Text(
              '${Brand.activity} · ${Brand.eventLine} · ${Brand.credit}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthSettingsTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(authStateProvider).valueOrNull == true;
    final username = ref.watch(usernameProvider).valueOrNull;
    return Column(
      children: [
        ListTile(
          title: Text(
            authed
                ? (username == null || username.isEmpty
                    ? 'Sesión API activa'
                    : 'Bienvenido, $username')
                : 'Sin JWT',
          ),
          subtitle: Text(
            authed
                ? 'Puedes subir a la Pecera del WiFi'
                : 'El escaneo funciona sin cuenta',
          ),
          trailing: Icon(authed ? Icons.verified_user : Icons.login),
        ),
        if (!authed) ...[
          ListTile(
            title: const Text('Iniciar sesión'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/login'),
          ),
          ListTile(
            title: const Text('Crear cuenta'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/register'),
          ),
          ListTile(
            title: const Text('Pegar JWT'),
            subtitle: const Text('Access token ya emitido por la API'),
            trailing: const Icon(Icons.vpn_key),
            onTap: () async {
              final token = await _promptJwt(context);
              if (token == null || token.trim().isEmpty) return;
              await ref.read(authStateProvider.notifier).importJwt(token);
              if (!context.mounted) return;
              final err = ref.read(authStateProvider).error;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    err == null ? 'JWT guardado' : 'No se pudo guardar el JWT',
                  ),
                ),
              );
            },
          ),
        ] else
          ListTile(
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.logout),
            onTap: () async {
              await ref.read(authStateProvider.notifier).logout();
            },
          ),
      ],
    );
  }
}

Future<String?> _promptJwt(BuildContext context) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Pegar JWT'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'access',
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, controller.text),
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
