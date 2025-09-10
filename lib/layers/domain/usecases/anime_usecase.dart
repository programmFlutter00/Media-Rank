import 'package:dartz/dartz.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/anime_repository.dart';

class AnimeUsecase {
  final AnimeRepository repository;
  AnimeUsecase(this.repository);

  Future<Either<String, List<AnimeEntity>>> getUpcoming({String type = 'upcoming', int page = 1, int limit = 20}) {
    return repository.getUpcoming(page: page, limit: limit);
  }

    Future<Either<String, List<AnimeEntity>>> getCurrentYearAnime({int page = 1, int limit = 20}) {
    return repository.getCurrentYearAnime(page: page, limit: limit);
  }
}
