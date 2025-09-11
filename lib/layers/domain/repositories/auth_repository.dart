// layers/domain/repository/auth/auth_repository.dart
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_in.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_up.dart';

abstract class AuthRepository {
  Future<bool> signIn(SignIn signIn);
  Future<bool> signUp(SignUp signUp);
  Future<void> signOut();
}
