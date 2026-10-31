import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/models.dart';
import '../../../core/theme/brand.dart';
import '../../auth/domain/auth_repository.dart';
import '../../auth/presentation/account_action.dart';
import '../../scanning/domain/session_controller.dart';

class LiveScreen extends ConsumerWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counters = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final running = counters.sessionStatus == SessionStatus.running;
    final paused = counters.sessionStatus == SessionStatus.paused;
    final active = running || paused;
    final username = ref.watch(usernameProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Brand.activity),
        actions: const [AccountAppBarAction()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              children: [
                _EventBanner(username: username),
                const SizedBox(height: 20),
                Text(
                  'Estado: ${counters.sessionStatus.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (counters.scanHint.isNotEmpty)
                  Text(counters.scanHint, style: Theme.of(context).textTheme.bodySmall),
                if (counters.wifiThrottled)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Android está limitando Wi‑Fi. En Opciones de desarrollador desactiva “Wi‑Fi scan throttling”.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                const SizedBox(height: 12),
                _CounterTile(label: 'Wi‑Fi', value: counters.wifiCount),
                _CounterTile(label: 'BLE', value: counters.bleCount),
                _CounterTile(label: 'LTE', value: counters.lteCount),
                const SizedBox(height: 8),
                Text('GPS: ${counters.gpsStatus}'),
                Text('Upload: ${counters.uploadStatus}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!active)
                  FilledButton(
                    onPressed: () async {
                      try {
                        await controller.start();
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$e')),
                          );
                        }
                      }
                    },
                    child: const Text('Start'),
                  ),
                if (running)
                  OutlinedButton(
                    onPressed: controller.pause,
                    child: const Text('Pause'),
                  ),
                if (paused)
                  OutlinedButton(
                    onPressed: controller.resume,
                    child: const Text('Resume'),
                  ),
                if (active)
                  OutlinedButton(
                    onPressed: controller.stop,
                    child: const Text('Stop'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventBanner extends StatelessWidget {
  const _EventBanner({this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    final welcome = (username != null && username!.isNotEmpty)
        ? 'Bienvenido, $username'
        : 'Entra para subir a la pecera';
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
      decoration: BoxDecoration(
        color: Brand.tarjeta,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(Brand.mascot, height: 64, filterQuality: FilterQuality.medium),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Brand.activity,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${Brand.villageLine} · ${Brand.eventLine}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  welcome,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Brand.lima,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const CreditLine(compact: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterTile extends StatelessWidget {
  const _CounterTile({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Brand.tarjeta,
      elevation: 0,
      child: ListTile(
        title: Text(label),
        trailing: Text(
          '$value',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
