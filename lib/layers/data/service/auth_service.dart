import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUp(SignUp signUp) async {
    try {
      // FirebaseAuth orqali user yaratish
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(signUp.userName);
        await user.reload();

        // UserModel yaratish
        final userModel = UserModel(
          uid: user.uid,
          email: signUp.email,
          userName: signUp.userName,
          photoUrl: null,
          createdAt: DateTime.now(),
        );

        // Firestorega yozish
        await _firestore.collection('users').doc(user.uid).set(userModel.toJson());

        return userModel;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }

  Future<UserModel?> signIn(SignIn signIn) async {
    try {
      // Auth orqali login
      await _firebaseAuth.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );

      // Firestore’dan userni olish
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromJson(doc.data()!);
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Login Error: ${e.toString()}');
      return null;
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

  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }
}
