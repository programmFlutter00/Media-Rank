import 'package:my_anime_hero_list/core/di/di.dart';
import 'package:my_anime_hero_list/core/network/api_client.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_current_year/cubit/anime_current_year_cubit.dart';
import 'package:my_anime_hero_list/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
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
  sl.registerFactory(() => AnimeUpcomingCubit(sl<AnimeUsecase>()));
  sl.registerFactory(() => AnimeCurrentYearCubit(sl<AnimeUsecase>()));
}