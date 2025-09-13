import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_up_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_out_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/get_current_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthState()) {
    _initializeAuthState();
  }

  void _initializeAuthState() {
    _authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      debugPrint('Auth state changed: ${firebaseUser != null ? 'User logged in' : 'User logged out'}');

      if (firebaseUser != null) {
        final user = await _getCurrentUserUseCase();
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
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
    final user = await _signInUseCase(signIn);
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: "SignIn failed",
      ));
    }
  }

  Future<void> signUp(SignUp signUp) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final user = await _signUpUseCase(signUp);
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
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
      // Firebase Auth profilini yangilash
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }

      await user.reload();

      // Firestore profilini yangilash
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        if (displayName != null) 'displayName': displayName,
        if (photoURL != null) 'photoURL': photoURL,
      });

      // yangilangan userni olish
      final updatedUser = await _getCurrentUserUseCase();

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: updatedUser,
      ));
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
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
