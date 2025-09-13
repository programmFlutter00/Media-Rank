import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/core/network/api_client.dart';
import 'package:media_rank/layers/application/anime/anime_character/cubit/anime_character_cubit.dart';
import 'package:media_rank/layers/application/anime/anime_current_year/cubit/anime_current_year_cubit.dart';
import 'package:media_rank/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
import 'package:media_rank/layers/data/repositories/anime_repository_impl.dart';
import 'package:media_rank/layers/data/service/anime_service.dart';
import 'package:media_rank/layers/domain/repositories/anime_repository.dart';
import 'package:media_rank/layers/domain/usecases/anime_usecase.dart';

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
  sl.registerFactory(() => AnimeCharacterCubit(sl<AnimeUsecase>()));
}