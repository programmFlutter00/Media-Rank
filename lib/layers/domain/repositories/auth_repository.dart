// layers/domain/repositories/auth_repository.dart
import 'package:media_rank/layers/domain/entities/auth/sign_in.dart';
import 'package:media_rank/layers/domain/entities/auth/sign_up.dart';
import 'package:media_rank/layers/domain/entities/auth/user_model.dart';

abstract class AuthRepository {
  /// Foydalanuvchini login qilamiz
  Future<UserModel?> signIn(SignIn signIn);

  /// Yangi foydalanuvchini ro‘yxatdan o‘tkazamiz
  Future<UserModel?> signUp(SignUp signUp);

  /// Tizimdan chiqish
  Future<void> signOut();

  /// Hozirgi foydalanuvchini olish (agar mavjud bo‘lsa)
  Future<UserModel?> getCurrentUser();
}
