import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/env.dart';
import 'core/theme/app_theme.dart';
import 'routing/app_router.dart';

/// Shell MaterialApp + tema accent (#00A676 por defecto).
class WardrivingApp extends ConsumerWidget {
  const WardrivingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accent = Env.accentColor;
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Wardriving',
      theme: AppTheme.light(accent),
      darkTheme: AppTheme.dark(accent),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
