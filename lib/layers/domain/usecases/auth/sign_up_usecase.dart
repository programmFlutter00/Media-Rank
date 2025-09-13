// layers/domain/usecases/auth/sign_up_usecase.dart
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserModel?> call(SignUp signUp) {
    return repository.signUp(signUp);
  }
}
