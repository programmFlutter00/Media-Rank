import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/layers/application/auth/cubit/auth_cubit.dart';
import 'package:my_anime_hero_list/layers/data/repositories/auth_repository_impl.dart';
import 'package:my_anime_hero_list/layers/data/service/auth_service.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/auth_repository.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_out_usecase.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/auth/sign_up_usecase.dart';

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
  sl.registerFactory(
    () => AuthCubit(
      sl<SignInUseCase>(),
      sl<SignUpUseCase>(),
      sl<SignOutUseCase>(),
    ),
  );
}
