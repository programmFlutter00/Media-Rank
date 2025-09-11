// layers/application/auth/auth_cubit.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 🔹 Firestore import qilindi
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_in.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_up.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_up_usecase.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_out_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
  ) : super(const AuthState()) {
    _initializeAuthState();
  }

  void _initializeAuthState() {
    _authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      debugPrint(
          'Auth state changed: ${user != null ? 'User logged in' : 'User logged out'}');

      if (user != null) {
        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    }, onError: (error) {
      debugPrint('Auth state change error: $error');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Authentication error occurred',
      ));
    });
  }

  Future<void> signIn(SignIn signIn) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _signInUseCase(signIn);
    if (!result) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: "SignIn failed",
      ));
    }
  }

  Future<void> signUp(SignUp signUp) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _signUpUseCase(signUp);
    if (!result) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: "SignUp failed",
      ));
    }
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (displayName != null) await user.updateDisplayName(displayName);
        if (photoURL != null) await user.updatePhotoURL(photoURL);
        await user.reload();

        // Firestore update
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          if (displayName != null) 'displayName': displayName,
          if (photoURL != null) 'photoURL': photoURL,
        });

        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'User not logged in',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    await _signOutUseCase();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
