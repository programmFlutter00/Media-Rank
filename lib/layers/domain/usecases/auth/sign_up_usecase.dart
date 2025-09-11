// layers/domain/usecases/auth/sign_up_usecase.dart
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_up.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<bool> call(SignUp signUp) {
    return repository.signUp(signUp);
  }
}
