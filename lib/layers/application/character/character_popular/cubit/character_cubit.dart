import 'package:bloc/bloc.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/character_usecase.dart';
part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterUsecase usecase;

  CharacterCubit(this.usecase) : super(const CharacterState());

  Future<void> getCharacters({int page = 1, int limit = 20}) async {
    if (page == 1) {
      emit(state.copyWith(
        status: CharacterStatus.loading,
        mode: CharacterMode.normal,
        error: null,
      ));
    }

    final result = await usecase.getCharacters(page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(status: CharacterStatus.failed, error: error)),
      (characters) {
        final merged = page == 1 ? characters : [...state.characters, ...characters];
        emit(state.copyWith(
          status: CharacterStatus.success,
          mode: CharacterMode.normal,
          characters: merged,
          currentPage: page,
          hasMore: characters.length == limit,
          error: null,
        ));
      },
    );
  }

  Future<void> getPopularCharacters({int page = 1, int limit = 20}) async {
    if (page == 1) {
      emit(state.copyWith(
        status: CharacterStatus.loading,
        mode: CharacterMode.popular,
        error: null,
      ));
    }

    final result = await usecase.getPopularCharacters(page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(status: CharacterStatus.failed, error: error)),
      (characters) {
        final merged = page == 1 ? characters : [...state.characters, ...characters];
        emit(state.copyWith(
          status: CharacterStatus.success,
          mode: CharacterMode.popular,
          characters: merged,
          currentPage: page,
          hasMore: characters.length == limit,
          error: null,
        ));
      },
    );
  }

  Future<void> searchCharacters(String query, {int page = 1, int limit = 20}) async {
    if (page == 1) {
      emit(state.copyWith(
        status: CharacterStatus.loading,
        mode: CharacterMode.search,
        error: null,
      ));
    }

    final result = await usecase.searchCharacters(query, page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(status: CharacterStatus.failed, error: error)),
      (characters) {
        final merged = page == 1 ? characters : [...state.characters, ...characters];
        emit(state.copyWith(
          status: CharacterStatus.success,
          mode: CharacterMode.search,
          characters: merged,
          currentPage: page,
          hasMore: characters.length == limit,
          error: null,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore) return;
    final nextPage = state.currentPage + 1;

    if (state.mode == CharacterMode.normal) {
      await getCharacters(page: nextPage);
    } else if (state.mode == CharacterMode.popular) {
      await getPopularCharacters(page: nextPage);
    } else if (state.mode == CharacterMode.search) {
      // search uchun query kerak bo‘ladi (uni keyinchalik statega qo‘shish mumkin)
    }
  }

  Future<void> refresh() async {
    if (state.mode == CharacterMode.normal) {
      await getCharacters(page: 1);
    } else if (state.mode == CharacterMode.popular) {
      await getPopularCharacters(page: 1);
    } else if (state.mode == CharacterMode.search) {
      // search uchun query kerak bo‘ladi
    }
  }
}
