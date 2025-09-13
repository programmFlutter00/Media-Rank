import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/layers/application/auth/cubit/auth_cubit.dart';
import 'package:media_rank/layers/data/repositories/auth_repository_impl.dart';
import 'package:media_rank/layers/data/service/auth_service.dart';
import 'package:media_rank/layers/domain/repositories/auth_repository.dart';
import 'package:media_rank/layers/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_out_usecase.dart';
import 'package:media_rank/layers/domain/usecases/auth/sign_up_usecase.dart';

Future<void> setupAuthDi() async {
  // Service
  sl.registerLazySingleton<AuthService>(() => AuthService());

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthService>()),
  );

  // UseCase
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl<AuthRepository>()));
  sl.registerFactory(
    () => AuthCubit(
      sl<SignInUseCase>(),
      sl<SignUpUseCase>(),
      sl<SignOutUseCase>(),
      sl<GetCurrentUserUseCase>(),
    ),
  );
}
