import 'package:flutter/material.dart';
import '../features/auth/auth_gate.dart';

class FlutterTasksApp extends StatelessWidget {
  const FlutterTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tasks App',
      theme: ThemeData(useMaterial3: true),
      home: const AuthGate(),
    );
  }
}
