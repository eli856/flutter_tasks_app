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
    resizeToAvoidBottomInset: true, // let scaffold move when keyboard opens
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 20, 58),
            Color.fromARGB(255, 2, 24, 122),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // make content at least as tall as the screen
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // logo
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/notes-logo.png',
                          width: 60,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Notes App',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        'Organize your thoughts and tasks',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 36),

                      // white card with form
                      Container(
                        width: 340,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Email'),
                              ),
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Enter your email',
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Enter email'
                                        : null,
                              ),
                              const SizedBox(height: 16),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Password'),
                              ),
                              TextFormField(
                                controller: pass,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Enter your password',
                                ),
                                validator: (v) =>
                                    (v == null || v.length < 6)
                                        ? 'Min 6 characters'
                                        : null,
                              ),
                              const SizedBox(height: 12),
                              if (error != null)
                                Text(
                                  error!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    minimumSize:
                                        const Size.fromHeight(44),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState
                                            ?.validate() ==
                                        true) {
                                      submit();
                                    }
                                  },
                                  child: Text(
                                    isLogin ? 'Log in' : 'Sign up',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      'or',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 122, 122, 122),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize:
                                        const Size.fromHeight(44),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _handleGoogleSignIn,
                                  icon: const Icon(Icons.g_mobiledata),
                                  label: const Text(
                                    'Continue with Google',
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    setState(() => isLogin = !isLogin),
                                child: Text(
                                  isLogin
                                      ? 'Create an account'
                                      : 'I have an account',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

}
