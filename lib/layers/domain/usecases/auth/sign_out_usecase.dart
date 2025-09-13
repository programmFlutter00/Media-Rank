// layers/domain/usecases/auth/sign_out_usecase.dart
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
