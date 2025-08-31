import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';

class AnimeService {
  final Dio _dio;

  AnimeService(this._dio);

  /// Yangiliklar/chiqishi mumkin bo‘lgan animelar
  Future<Either<String, List<AnimeEntity>>> getUpcomingAnime({
    required String type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
       String endpoint = '';
       switch (type) {
         case 'upcoming':
           endpoint = '/seasons/upcoming'; // chiqishi mumkin bo‘lgan animelar
           break;
         case 'now':
           endpoint = '/seasons/now'; // chiqishi mumkin bo‘lgan animelar
           break;
         default:
           endpoint = '/seasons/now';
       }
      final response = await _dio.get(
        // '/top/anime',
        endpoint,
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
