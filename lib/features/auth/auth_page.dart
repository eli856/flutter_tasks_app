import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tasks_app/features/auth/google_auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final _googleAuthService = GoogleAuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String? error;

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() => error = null);
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: pass.text,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: pass.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => error = e.message);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => error = null);
    try {
      final user = await _googleAuthService.signInWithGoogle();
      if (user == null) {
        return;
      }
    } on FirebaseAuthException catch (e) {
      setState(() => error = e.message);
    } catch (e, st) {
      debugPrint('Google sign-in error: $e');
      debugPrintStack(stackTrace: st);
      setState(() => error = e.toString());
      // setState(() => error = "Google sign-in failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Sign in' : 'Create account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter email' : null,
              ),
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) =>
                    (v == null || v.length < 6) ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 12),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    submit();
                  }
                },
                child: Text(isLogin ? 'Log in' : 'Sign up'),
              ),

              const SizedBox(height: 8),
              const Text('or'),
              const SizedBox(height: 8),

              OutlinedButton.icon(
                onPressed: _handleGoogleSignIn,
                icon: const Icon(
                  Icons.g_mobiledata,
                ),
                label: const Text('Continue with Google'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin ? 'Create an account' : 'I have an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
