part of 'anime_upcoming_cubit.dart';

enum AnimeUpcomingStatus { initial, loading, success, failed }

class AnimeUpcomingState extends Equatable {
  const AnimeUpcomingState({
    this.status = AnimeUpcomingStatus.initial,
    this.animeList = const [],
    this.error,
    this.currentPage = 0,
    this.hasMore = true,
  });

  final AnimeUpcomingStatus status;
  final List<AnimeEntity> animeList;
  final String? error;
  final int currentPage;
  final bool hasMore;

  AnimeUpcomingState copyWith({
    AnimeUpcomingStatus? status,
    List<AnimeEntity>? animeList,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return AnimeUpcomingState(
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
