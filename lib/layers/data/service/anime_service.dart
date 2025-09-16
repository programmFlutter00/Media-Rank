import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_rank/layers/domain/entities/anime_character_entity.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';

class AnimeService {
  final Dio _dio;

  AnimeService(this._dio);

  /// 🔹 Chiqishi kutilayotgan anime roʻyxati
  Future<Either<String, List<AnimeEntity>>> getUpcomingAnime({
  int page = 1,
  int end = 15,
  int limit = 20,
}) async {
  try {
    print('🌐 Loading upcoming anime from API...');

    List<AnimeEntity> allAnime = [];

    // Birinchi sahifadan boshlaymiz
    final firstResponse = await _dio.get(
      '/seasons/upcoming',
      queryParameters: {
        'page': page,
        'limit': limit,
        'sort': 'desc',
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'MyAnimeHeroList/1.0',
        },
      ),
    );

    if (firstResponse.statusCode == 200) {
      final List<dynamic> firstData = firstResponse.data['data'] ?? [];
      final firstPage =
          firstData.map((a) => AnimeEntity.fromJson(a)).toList();
      allAnime = firstPage;
    } else {
      return const Left('❌ Failed to fetch first page');
    }

    // Agar birinchi sahifa muvaffaqiyatli bo‘lsa, qolganlarini yuklash
    if (allAnime.isNotEmpty && page < end) {
      try {
        for (int current = page; current <= end; current++) {
          await Future.delayed(
              const Duration(milliseconds: 1000)); // Rate-limit uchun

          final response = await _dio.get(
            '/seasons/upcoming',
            queryParameters: {
              'page': current,
              'limit': limit,
              'sort': 'desc',
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'User-Agent': 'MyAnimeHeroList/1.0',
              },
            ),
          );

          if (response.statusCode == 200) {
            final List<dynamic> data = response.data['data'] ?? [];
            final pageAnime =
                data.map((a) => AnimeEntity.fromJson(a)).toList();
            allAnime.addAll(pageAnime);
            print("✅ Page $current yuklandi (${pageAnime.length} item)");
          } else {
            print("⚠️ Failed to fetch page $current");
          }
        }
      } catch (e) {
        print('⚠️ Additional pages failed: $e');
      }
    }

    print('✅ Loaded ${allAnime.length} anime from API');
    return Right(allAnime);
  } on DioException catch (e) {
    return Left(
      e.response != null
          ? 'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}'
          : 'Network error occurred',
    );
  } catch (e) {
    return Left('❌ Unexpected error: $e');
  }
}


  /// 🔹 Joriy yildagi anime roʻyxati
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
        return const Left('Failed to fetch current year anime');
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

  /// 🔹 Anime bo‘yicha personajlar va ovoz aktyorlari
  Future<Either<String, List<AnimeCharacterEntity>>> getAnimeCharacters({
    required int animeId,
  }) async {
    try {
      final response = await _dio.get(
        '/anime/$animeId/characters',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'MyAnimeHeroList/1.0',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final characters = data
            .map((c) => AnimeCharacterEntity.fromJson(c))
            .toList();
        return Right(characters);
      } else {
        return const Left('Failed to fetch anime characters');
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
