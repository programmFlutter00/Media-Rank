import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/core/network/api_client.dart';
import 'package:my_anime_hero_list/layers/application/character/character_popular/cubit/character_cubit.dart';
import 'package:my_anime_hero_list/layers/data/repositories/character_repository_impl.dart';
import 'package:my_anime_hero_list/layers/data/service/character_service.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/character_repository.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/character_usecase.dart';

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