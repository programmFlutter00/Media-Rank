// layers/domain/usecases/auth/sign_in_usecase.dart
import 'package:my_anime_hero_list/layers/domain/entities/auth/sign_in.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<bool> call(SignIn signIn) {
    return repository.signIn(signIn);
  }
}
