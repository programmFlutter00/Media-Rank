import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/anime_usecase.dart';

part 'anime_state.dart';

class AnimeCubit extends Cubit<AnimeState> {
  final AnimeUsecase _usecase;
  AnimeCubit(this._usecase) : super(const AnimeState());

  Future<void> getUpcoming({String type = 'upcoming',int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(status: AnimeStatus.loading, error: null));
    }

    final result = await _usecase.getUpcoming(type: type, page: page);

    result.fold(
      (error) => emit(state.copyWith(status: AnimeStatus.failed, error: error)),
      (list) {
        final merged = page == 1 ? list : [...state.animeList, ...list];
        final hasMore = list.length >= 20; // limit=20
        emit(state.copyWith(
          status: AnimeStatus.success,
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
