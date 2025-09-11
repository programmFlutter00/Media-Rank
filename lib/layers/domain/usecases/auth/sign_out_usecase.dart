// layers/domain/usecases/auth/sign_out_usecase.dart
import 'package:my_anime_hero_list/layers/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
