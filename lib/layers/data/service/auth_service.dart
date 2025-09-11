import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_in.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_up.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn(SignIn signIn) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.message}');
      return false; // Return false instead of throwing
    } catch (e) {
      debugPrint('Login Error: ${e.toString()}');
      return false; // Return false for any other errors
    }
  }

  Future<bool> signUp(SignUp signUp) async {
    try {
      // User yaratish
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: signUp.email,
            password: signUp.password,
          );

      // User olish
      User? user = userCredential.user;

      if (user != null) {
        // Ismni saqlash
        await user.updateDisplayName(signUp.userName);

        // Agar profilni qayta yuklamoqchi bo‘lsangiz:
        await user.reload();
      }

      return true;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Sign out error: ${e.toString()}');
      rethrow;
    }
  }
}
