import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/core/network/api_client.dart';
import 'package:my_anime_hero_list/layers/application/anime/cubit/anime_cubit.dart';
import 'package:my_anime_hero_list/layers/data/repositories/anime_repository_impl.dart';
import 'package:my_anime_hero_list/layers/data/service/anime_service.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/anime_repository.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/anime_usecase.dart';

Future<void> setupAnimeDI() async{
  // Service
  sl.registerLazySingleton<AnimeService>(() => AnimeService(sl<ApiClient>().dio));

  // Repository
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepositoryImpl(sl<AnimeService>()));

  // UseCase
  sl.registerLazySingleton(() => AnimeUsecase(sl<AnimeRepository>()));

  // Cubit
  sl.registerFactory(() => AnimeCubit(sl<AnimeUsecase>()));
}