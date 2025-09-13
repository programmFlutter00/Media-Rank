import 'package:media_rank/layers/domain/entities/auth/user_model.dart';
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserModel?> call() {
    return repository.getCurrentUser();
  }
}
