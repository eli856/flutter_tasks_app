import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_tasks_app/features/auth/presentation/auth_page.dart';
import 'package:flutter_tasks_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_tasks_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_tasks_app/features/notes/presentation/pages/notes_page.dart';


/// Small helper so go_router refreshes when the auth stream changes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Expose a single GoRouter instance via Riverpod.
final goRouterProvider = Provider<GoRouter>((ref) {
  // Get FirebaseAuth from our provider
  final auth = ref.watch(firebaseAuthProvider);

  return GoRouter(
    initialLocation: '/',
    // This will trigger router refreshes whenever auth state changes
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),

    redirect: (context, state) {
      final user = auth.currentUser;
      final loggingIn = state.matchedLocation == '/login';

      // Not signed in → force /login
      if (user == null) {
        return loggingIn ? null : '/login';
      }

      // Signed in → keep them away from /login and root
      if (loggingIn || state.matchedLocation == '/') {
        return '/home';
      }

      return null; // no redirect
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final user = auth.currentUser;
          if (user == null) {
            return const AuthPage();
          }
          return HomePage(user: user);
        },
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const NotesPage(),
      ),
    ],
  );
});
