import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/models.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Live')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Estado: ${counters.sessionStatus.name.toUpperCase()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (counters.sessionId != null)
              Text('Sesión: ${counters.sessionId}', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            _CounterTile(label: 'Wi‑Fi', value: counters.wifiCount),
            _CounterTile(label: 'BLE', value: counters.bleCount),
            _CounterTile(label: 'LTE', value: counters.lteCount),
            const SizedBox(height: 8),
            Text('GPS: ${counters.gpsStatus}'),
            Text('Upload: ${counters.uploadStatus}'),
            const Spacer(),
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
