import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';
import 'package:media_rank/layers/domain/usecases/anime_usecase.dart';

part 'anime_current_year_state.dart';

class AnimeCurrentYearCubit extends Cubit<AnimeCurrentYearState> {
  final AnimeUsecase _usecase;
  AnimeCurrentYearCubit(this._usecase) : super(const AnimeCurrentYearState());

  Future<void> getCurrentYearAnime({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(status: AnimeCurrentYearStatus.loading, error: null));
    }

    final result = await _usecase.getCurrentYearAnime(page: page);

    result.fold(
      (error) => emit(
        state.copyWith(status: AnimeCurrentYearStatus.failed, error: error),
      ),
      (list) {
        final merged = page == 1 ? list : [...state.animeList, ...list];
        final hasMore = list.length >= 20; // limit=20
        emit(
          state.copyWith(
            status: AnimeCurrentYearStatus.success,
            animeList: merged,
            currentPage: page,
            hasMore: hasMore,
            error: null,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore) return;
    final nextPage = state.currentPage + 1;
    await getCurrentYearAnime(page: nextPage);
  }

  Future<void> refresh() async {
    await getCurrentYearAnime(page: 1);
  }
}
