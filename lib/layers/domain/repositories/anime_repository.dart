import 'package:dartz/dartz.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';

abstract class AnimeRepository {
  Future<Either<String, List<AnimeEntity>>> getUpcoming({int page, int limit});
  Future<Either<String, List<AnimeEntity>>> getCurrentYearAnime({int page, int limit});

}