import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        'success': true,
        'uid': userCredential.user?.uid,
      };
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'error': e.message ?? 'Unknown error occurred',
      };
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        'success': true,
        'uid': userCredential.user?.uid,
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'error': 'The email address is already in use by another account.',
        };
      }
      return {
        'success': false,
        'error': e.message ?? 'Unknown error occurred',
      };
    }
  }
}
