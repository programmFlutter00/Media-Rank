import 'package:dartz/dartz.dart';
import 'package:media_rank/layers/domain/entities/anime_character_entity.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';

abstract class AnimeRepository {
  Future<Either<String, List<AnimeEntity>>> getUpcoming({int page, int end, int limit});
  Future<Either<String, List<AnimeEntity>>> getCurrentYearAnime({int page, int limit});
  Future<Either<String, List<AnimeCharacterEntity>>> getAnimeCharacters({required int animeId});
}
