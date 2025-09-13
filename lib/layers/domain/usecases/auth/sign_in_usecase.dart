// layers/domain/usecases/auth/sign_in_usecase.dart
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserModel?> call(SignIn signIn) {
    return repository.signIn(signIn);
  }
}
