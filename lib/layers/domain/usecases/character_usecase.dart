// import 'package:dartz/dartz.dart';
// import 'package:media_rank/layers/domain/entities/character_entity.dart';
// import 'package:media_rank/layers/domain/repositories/character_repository.dart';

// class CharacterUsecase {
//     final CharacterRepository repository;

//   const CharacterUsecase(this.repository);

//   Future<Either<String, List<CharacterEntity>>> call() {
//     return repository.getCharacters();
//   }

//   Future<Either<String, List<CharacterEntity>>> searchCharacters(String query) {
//     return repository.searchCharacters(query);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:media_rank/layers/domain/entities/character_entity.dart';
import 'package:media_rank/layers/domain/repositories/character_repository.dart';

class CharacterUsecase {
  final CharacterRepository repository;
  const CharacterUsecase(this.repository);

 Future<Either<String, List<CharacterEntity>>> getPopularCharacters({
    int page = 1,
    int limit = 20,
  }) {
    return repository.getPopularCharacters(page: page, limit: limit);
  }

  Future<Either<String, List<CharacterEntity>>> getCharacters({
    int page = 1,
    int limit = 20,
  }) {
    return repository.getCharacters(page: page, limit: limit);
  }

  Future<Either<String, List<CharacterEntity>>> searchCharacters(
    String query, {
    int page = 1,
    int limit = 20,
  }) {
    return repository.searchCharacters(query, page: page, limit: limit);
  }
}
