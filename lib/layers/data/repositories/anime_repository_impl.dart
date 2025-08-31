import 'package:dartz/dartz.dart';
import 'package:my_anime_hero_list/layers/data/service/anime_service.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeService _service;
  AnimeRepositoryImpl(this._service);

@override
Future<Either<String, List<AnimeEntity>>> getUpcoming({String type = 'upcoming',int page = 1, int limit = 20}) async {
  final result = await _service.getUpcomingAnime(type: type, page: page, limit: limit);
  return result.fold((l) => Left(l), (r) => Right(r));
}

}
