part of 'anime_current_year_cubit.dart';

enum AnimeCurrentYearStatus { initial, loading, success, failed }

class AnimeCurrentYearState extends Equatable {
  const AnimeCurrentYearState({
    this.status = AnimeCurrentYearStatus.initial,
    this.animeList = const [],
    this.error,
    this.currentPage = 0,
    this.hasMore = true,
  });

  final AnimeCurrentYearStatus status;
  final List<AnimeEntity> animeList;
  final String? error;
  final int currentPage;
  final bool hasMore;

  AnimeCurrentYearState copyWith({
    AnimeCurrentYearStatus? status,
    List<AnimeEntity>? animeList,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return AnimeCurrentYearState(
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
