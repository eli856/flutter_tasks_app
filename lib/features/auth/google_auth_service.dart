import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    await _googleSignIn.initialize(
      serverClientId:
          '2614100063-jnjqod7me7hcal9m6br6ug97ci42pbbp.apps.googleusercontent.com',
    );

    _initialized = true;
  }

  Future<User?> signInWithGoogle() async {
    await _ensureInitialized();

    try {
      // 1. Open Google account chooser / sign-in
      final googleUser = await _googleSignIn.authenticate();

      // 2. Get auth tokens (idToken is enough for Firebase)
      final googleAuth = googleUser.authentication;

      // 3. Build a Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with that credential
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User canceled the dialog
        return null;
      } else {
        // Re-throw any other Google sign-in errors
        rethrow;
      }
    }
  }
}
