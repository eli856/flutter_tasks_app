import 'package:flutter/material.dart';
import '../features/auth/presentation/auth_gate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks_app/routing/app_router.dart';

class FlutterTasksApp extends ConsumerWidget {

  static const kPrimaryColor = Color(0xFF02187A);
  static const kSecondaryColor = Color(0xFF0059C2);
  static const kAccentColor = Color(0xFF00C2FF);
  static const kSurfaceColor = Colors.white;
  static const kErrorColor = Colors.red;

  const FlutterTasksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter Tasks App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          surface: kSurfaceColor,
          error: kErrorColor,
          brightness: Brightness.light,
        ),

        
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kPrimaryColor,
            side: BorderSide(color: kPrimaryColor),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: kSecondaryColor),
        ),
      ),
      // home: const AuthGate(),
    );
  }
}
