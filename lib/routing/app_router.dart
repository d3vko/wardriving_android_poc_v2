import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/domain/auth_repository.dart';
import '../features/auth/presentation/auth_screens.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/export/presentation/export_screen.dart';
import '../features/live/presentation/live_screen.dart';
import '../features/sessions/presentation/sessions_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

/// Un solo GoRouter. El escaneo no exige JWT; login es opcional.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/live',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/password-recovery',
        builder: (context, state) => const PasswordRecoveryScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return FieldShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/live',
                builder: (context, state) => const LiveScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sessions',
                builder: (context, state) => const SessionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/export',
                builder: (context, state) => const ExportScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class FieldShell extends ConsumerWidget {
  const FieldShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    (label: 'Pecera', asset: 'assets/icons/nav/live.png'),
    (label: 'Dashboard', asset: 'assets/icons/nav/dashboard.png'),
    (label: 'Sessions', asset: 'assets/icons/nav/sessions.png'),
    (label: 'Export', asset: 'assets/icons/nav/export.png'),
    (label: 'Settings', asset: 'assets/icons/nav/settings.png'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(authStateProvider).valueOrNull == true;

    return Scaffold(
      body: Column(
        children: [
          if (!authed)
            Material(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: ListTile(
                dense: true,
                leading: const Icon(Icons.cloud_off),
                title: const Text('Escaneo local. Inicia sesión para subir.'),
                trailing: TextButton(
                  onPressed: () => context.push('/login'),
                  child: const Text('Login'),
                ),
              ),
            ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Opacity(
                opacity: 0.62,
                child: Image.asset(
                  d.asset,
                  width: 24,
                  height: 24,
                  filterQuality: FilterQuality.medium,
                  semanticLabel: d.label,
                ),
              ),
              selectedIcon: Image.asset(
                d.asset,
                width: 24,
                height: 24,
                filterQuality: FilterQuality.medium,
                semanticLabel: d.label,
              ),
              label: d.label,
            ),
        ],
      ),
    );
  }
}
