import 'package:dartz/dartz.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/repositories/anime_repository.dart';

class AnimeUsecase {
  final AnimeRepository repository;
  AnimeUsecase(this.repository);

  Future<Either<String, List<AnimeEntity>>> getUpcoming({String type = 'upcoming', int page = 1, int limit = 20}) {
    return repository.getUpcoming(type: type, page: page, limit: limit);
  }
}
