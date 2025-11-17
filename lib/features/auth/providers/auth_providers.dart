import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expose FirebaseAuth instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Stream of the current user (null = logged out)
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});






































































