import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'config/env.dart';
import 'core/observability/crash_reporting.dart';
import 'features/scanning/domain/session_controller.dart';
import 'features/settings/data/app_settings_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  ensureSessionBindings();

  final prefs = await SharedPreferences.getInstance();

  Widget app() {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const WardrivingApp(),
    );
  }

  try {
    await SentryFlutter.init(
      CrashReporting.configureOptions,
      appRunner: () {
        CrashReporting.applyStartupScope();
        runApp(SentryWidget(child: app()));
      },
    );
  } catch (_) {
    // Self-hosted caído o DSN inválido no debe impedir abrir la app.
    runApp(app());
  }
}
