import 'package:dartz/dartz.dart';
import 'package:media_rank/layers/domain/entities/anime_character_entity.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';
import 'package:media_rank/layers/domain/repositories/anime_repository.dart';

class AnimeUsecase {
  final AnimeRepository repository;
  AnimeUsecase(this.repository);

  Future<Either<String, List<AnimeEntity>>> getUpcoming({
    int page = 1,
    int end = 1,
    int limit = 20,
  }) {
    return repository.getUpcoming(page: page,end: end, limit: limit);
  }

  Future<Either<String, List<AnimeEntity>>> getCurrentYearAnime({
    int page = 1,
    int limit = 20,
  }) {
    return repository.getCurrentYearAnime(page: page, limit: limit);
  }

  Future<Either<String, List<AnimeCharacterEntity>>> getAnimeCharacters({
    required int animeId,
  }) {
    return repository.getAnimeCharacters(animeId: animeId);
  }
}
