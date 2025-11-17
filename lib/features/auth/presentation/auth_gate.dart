import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_tasks_app/features/auth/presentation/auth_page.dart';
import 'package:flutter_tasks_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_tasks_app/features/home/presentation/pages/home_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // Not signed in → show login/register page
          // Push login route and display an empty widget while redirecting
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });
          return const SizedBox.shrink();
        }

        // Signed in → go to home dashboard
        return HomePage(user: user);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Auth error: $error')),
      ),
    );
  }
}
