import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/auth_repository.dart';

/// Acceso a login / cuenta desde cualquier AppBar de campo.
class AccountAppBarAction extends ConsumerWidget {
  const AccountAppBarAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(authStateProvider).valueOrNull == true;
    return IconButton(
      tooltip: authed ? 'Cuenta' : 'Iniciar sesión',
      icon: Icon(authed ? Icons.account_circle : Icons.login),
      onPressed: () {
        if (authed) {
          context.go('/settings');
        } else {
          context.push('/login');
        }
      },
    );
  }
}
