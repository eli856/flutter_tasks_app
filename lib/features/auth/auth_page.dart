import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final email = TextEditingController();
  final pass = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();

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
