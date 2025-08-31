part of 'anime_cubit.dart';

enum AnimeStatus { initial, loading, success, failed }

class AnimeState extends Equatable {
  const AnimeState({
    this.status = AnimeStatus.initial,
    this.animeList = const [],
    this.error,
    this.currentPage = 0,
    this.hasMore = true,
  });

  final AnimeStatus status;
  final List<AnimeEntity> animeList;
  final String? error;
  final int currentPage;
  final bool hasMore;

  AnimeState copyWith({
    AnimeStatus? status,
    List<AnimeEntity>? animeList,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return AnimeState(
      status: status ?? this.status,
      animeList: animeList ?? this.animeList,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, animeList, error, currentPage, hasMore];
}
