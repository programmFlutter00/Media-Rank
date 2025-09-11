// layers/data/repository/auth/auth_repository_impl.dart
import 'package:my_anime_hero_list/layers/data/service/auth_service.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_in.dart';
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_up.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _signUpService;

  AuthRepositoryImpl(this._signUpService);

  @override
  Future<bool> signIn(SignIn signIn) async {
    return await _signUpService.signIn(signIn);
  }

  @override
  Future<bool> signUp(SignUp signUp) async {
    return await _signUpService.signUp(signUp);
  }

  @override
  Future<void> signOut() async {
    return await _signUpService.signOut();
  }
}
