import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';

class AnimeService {
  final Dio _dio;

  AnimeService(this._dio);

  /// Yangiliklar/chiqishi mumkin bo‘lgan animelar
  Future<Either<String, List<AnimeEntity>>> getUpcomingAnime({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      
      final response = await _dio.get(
         '/seasons/upcoming',
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'MyAnimeHeroList/1.0',
          },
        ),
      );

      if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      final animeList = data.map((a) => AnimeEntity.fromJson(a)).toList();
      return Right(animeList);
      } else {
      return Left('Failed to fetch upcoming anime');
      }
    } on DioException catch (e) {
      return Left(
        e.response != null
            ? 'API Error: ${e.response?.statusCode}'
            : 'Network error occurred',
      );
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
  
    Future<Either<String, List<AnimeEntity>>> getCurrentYearAnime({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
       '/seasons/now',
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'MyAnimeHeroList/1.0',
          },
        ),
      );

      if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      final animeList = data.map((a) => AnimeEntity.fromJson(a)).toList();
      return Right(animeList);
      } else {
      return Left('Failed to fetch upcoming anime');
      }
    } on DioException catch (e) {
      return Left(
        e.response != null
            ? 'API Error: ${e.response?.statusCode}'
            : 'Network error occurred',
      );
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

}
