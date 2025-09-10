import 'package:dartz/dartz.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  
  // endi parametrlar bor: type, page, limit
  Future<Either<String, List<CharacterEntity>>> getPopularCharacters({
    int page = 1,
    int limit = 20,
  });


   Future<Either<String, List<CharacterEntity>>> getCharacters({
    int page = 1,
    int limit = 20,
  });

  Future<Either<String, List<CharacterEntity>>> searchCharacters(
    String query, {
    int page = 1,
    int limit = 20,
  });
}
