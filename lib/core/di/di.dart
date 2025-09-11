import 'package:get_it/get_it.dart';
import 'package:my_anime_hero_list/core/di/anime_di.dart';
import 'package:my_anime_hero_list/core/di/auth_di.dart';
import 'package:my_anime_hero_list/core/di/character_di.dart';
import 'package:my_anime_hero_list/core/network/api_client.dart';

final sl = GetIt.instance;

Future<void> setupSingletons() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient.instance);
  setupAuthDi();
  setupAnimeDI();
  setupCharacterDI();
}
