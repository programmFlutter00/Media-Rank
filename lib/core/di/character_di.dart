import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/core/network/api_client.dart';
import 'package:media_rank/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:media_rank/layers/data/repositories/character_repository_impl.dart';
import 'package:media_rank/layers/data/service/character_service.dart';
import 'package:media_rank/layers/domain/repositories/character_repository.dart';
import 'package:media_rank/layers/domain/usecases/character_usecase.dart';

Future<void> setupCharacterDI() async{
  // Service
  sl.registerLazySingleton<CharacterService>(() => CharacterService(sl<ApiClient>().dio));

  // Repository
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => CharacterUsecase(sl()));

  // Cubit
  sl.registerFactory(() => CharacterCubit(sl<CharacterUsecase>()));
}