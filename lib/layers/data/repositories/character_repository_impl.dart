// import 'package:dartz/dartz.dart';
// import 'package:media_rank/layers/data/service/character_service.dart';
// import 'package:media_rank/layers/domain/entities/character_entity.dart';
// import 'package:media_rank/layers/domain/repositories/character_repository.dart';

// class CharacterRepositoryImpl implements CharacterRepository {
//   final CharacterService service;

//   CharacterRepositoryImpl(this.service);

//   @override
//   Future<Either<String, List<CharacterEntity>>> getCharacters() {
//     return service.getTopCharacters();
//   }

//   @override
//   Future<Either<String, List<CharacterEntity>>> searchCharacters(String query) {
//     return service.searchCharacters(query: query);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:media_rank/layers/domain/entities/character_entity.dart';
import 'package:media_rank/layers/domain/repositories/character_repository.dart';
import 'package:media_rank/layers/data/service/character_service.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterService service;
  CharacterRepositoryImpl(this.service);
  

  @override
  Future<Either<String, List<CharacterEntity>>> getPopularCharacters({
    int page = 1,
    int limit = 20,
  }) async {
    final result = await service.getPopuarCharacters(page: page, limit: limit);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r), // r – CharacterResponse
    );
  }

  @override
  Future<Either<String, List<CharacterEntity>>> getCharacters({
    int page = 1,
    int limit = 20,
  }) async {
    final result = await service.getCharacters( page: page, limit: limit);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r), // r – CharacterResponse
    );
  }

  @override
  Future<Either<String, List<CharacterEntity>>> searchCharacters(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    final result = await service.searchCharacters(query: query, page: page, limit: limit);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
