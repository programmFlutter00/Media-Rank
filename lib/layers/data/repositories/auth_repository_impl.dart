// layers/data/repository/auth/auth_repository_impl.dart
import 'package:media_rank/layers/data/service/auth_service.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<UserModel?> signIn(SignIn signIn) async {
    return await _authService.signIn(signIn);
  }

  @override
  Future<UserModel?> signUp(SignUp signUp) async {
    return await _authService.signUp(signUp);
  }

  @override
  Future<void> signOut() async {
    return await _authService.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }
}
