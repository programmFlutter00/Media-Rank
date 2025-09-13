import 'package:get_it/get_it.dart';
import 'package:media_rank/core/di/anime_di.dart';
import 'package:media_rank/core/di/auth_di.dart';
import 'package:media_rank/core/di/character_di.dart';
import 'package:media_rank/core/network/api_client.dart';

final sl = GetIt.instance;

Future<void> setupSingletons() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient.instance);
  setupAuthDi();
  setupAnimeDI();
  setupCharacterDI();
}
