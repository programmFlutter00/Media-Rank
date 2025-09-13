import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';
import 'package:media_rank/layers/domain/usecases/anime_usecase.dart';

part 'anime_upcoming_state.dart';

class AnimeUpcomingCubit extends Cubit<AnimeUpcomingState> {
  final AnimeUsecase _usecase;
  AnimeUpcomingCubit(this._usecase) : super(const AnimeUpcomingState());

  Future<void> getUpcoming({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(status: AnimeUpcomingStatus.loading, error: null));
    }

    final result = await _usecase.getUpcoming(page: page);

    result.fold(
      (error) => emit(state.copyWith(status: AnimeUpcomingStatus.failed, error: error)),
      (list) {
        final merged = page == 1 ? list : [...state.animeList, ...list];
        final hasMore = list.length >= 20; // limit=20
        emit(state.copyWith(
          status: AnimeUpcomingStatus.success,
          animeList: merged,
          currentPage: page,
          hasMore: hasMore,
          error: null,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore) return;
    final nextPage = state.currentPage + 1;
    await getUpcoming(page: nextPage);
  }

  Future<void> refresh() async {
    await getUpcoming(page: 1);
  }
}
