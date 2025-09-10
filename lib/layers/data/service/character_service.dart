import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';

class CharacterService {
  CharacterService(this._dio);
  final Dio _dio;

  /// Get characters for different sections
  Future<Either<String, List<CharacterEntity>>> getPopuarCharacters({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // String endpoint = '';
      // Map<String, dynamic> queryParams = {'page': page, 'limit': limit};

      // switch (type) {
      //   case 'popular':
      //     endpoint = '/top/characters'; // eng mashhur personajlar
      //     break;
      //   case 'average':
      //     endpoint = '/characters'; // past reytingli personajlar
      //     queryParams.addAll({
      //       'order_by': 'favorites',
      //       'sort': 'desc', // yuqoridan pastga qarab
      //     });
      //     break;
      //   default:
      //     endpoint = '/characters';
      // }

      // final response = await _dio.get(endpoint, queryParameters: queryParams);
      final response = await _dio.get(
        '/top/characters',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final characters = data
            .map((c) => CharacterEntity.fromJson(c))
            .toList();
        return Right(characters);
      } else {
        return Left('Failed to fetch ');
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred';
      if (e.response != null) {
        errorMessage =
            'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      }
      return Left(errorMessage);
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  Future<Either<String, List<CharacterEntity>>> getCharacters({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
      // String endpoint = '/characters';
      // queryParams.addAll({'order_by': 'favorites', 'sort': 'desc'});

      // final response = await _dio.get(endpoint, queryParameters: queryParams);
      final response = await _dio.get(
        '/characters',
        queryParameters: {
          'page': page,
          'limit': limit,
          'order_by': 'favorites',
          'sort': 'desc',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final characters = data
            .map((c) => CharacterEntity.fromJson(c))
            .toList();
        return Right(characters);
      } else {
        return Left('Failed to fetch');
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred';
      if (e.response != null) {
        errorMessage =
            'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      }
      return Left(errorMessage);
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  /// Search characters
  Future<Either<String, List<CharacterEntity>>> searchCharacters({
    required String query,
    int page = 1,
    int limit = 25,
  }) async {
    try {
      final response = await _dio.get(
        '/characters',
        queryParameters: {'q': query, 'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final characters = data
            .map((character) => CharacterEntity.fromJson(character))
            .toList();
        return Right(characters);
      } else {
        return Left('Failed to search characters: ${response.statusCode}');
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred';
      if (e.response != null) {
        errorMessage =
            'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      }
      return Left(errorMessage);
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
