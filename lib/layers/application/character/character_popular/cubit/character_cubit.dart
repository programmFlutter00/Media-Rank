import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_anime_hero_list/layers/domain/entities/anime_entity.dart';
import 'package:my_anime_hero_list/layers/domain/entities/character_entity.dart';
import 'package:my_anime_hero_list/layers/domain/usecases/character_usecase.dart';

part 'character_state.dart';

// class CharacterCubit extends Cubit<CharacterState> {
//   CharacterCubit(this._characterUsecase) : super(const CharacterState());

//   final CharacterUsecase _characterUsecase;

//   Future<void> getCharacters() async {
//     emit(state.copyWith(status: CharacterStatus.loading));

//     final result = await _characterUsecase();

//     result.fold(
//       (e) => emit(state.copyWith(
//         error: e,
//         status: CharacterStatus.failed,
//       )),
//       (characters) => emit(state.copyWith(
//         characters: characters,
//         status: CharacterStatus.success,
//       )),
//     );
//   }
// }

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterUsecase usecase;

  CharacterCubit(this.usecase) : super(const CharacterState());

  Future<void> getCharacters({int page = 1, int limit = 20}) async {
    if (page == 1) {
      emit(state.copyWith(status: CharacterStatus.loading, error: null));
    }

    final result = await usecase.getCharacters(page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(
        status: CharacterStatus.failed,
        error: error,
      )),
      (characters) {
        final merged = page == 1
            ? characters
            : [...state.characters, ...characters];

        emit(state.copyWith(
          status: CharacterStatus.success,
          characters: merged,
          currentPage: page,
          hasMore: characters.length == limit, // agar limitdan kichik bo‘lsa, tugadi
          error: null,
        ));
      },
    );
  }

  Future<void> getPopularCharacters({int page = 1, int limit = 20}) async {
    if (page == 1) {
      emit(state.copyWith(status: CharacterStatus.loading, error: null));
    }

    final result = await usecase.getPopularCharacters(page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(
        status: CharacterStatus.failed,
        error: error,
      )),
      (characters) {
        final merged = page == 1
            ? characters
            : [...state.characters, ...characters];

        emit(state.copyWith(
          status: CharacterStatus.success,
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
      emit(state.copyWith(status: CharacterStatus.loading, error: null));
    }

    final result = await usecase.searchCharacters(query, page: page, limit: limit);

    result.fold(
      (error) => emit(state.copyWith(
        status: CharacterStatus.failed,
        error: error,
      )),
      (characters) {
        final merged = page == 1
            ? characters
            : [...state.characters, ...characters];

        emit(state.copyWith(
          status: CharacterStatus.success,
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
    await getCharacters(page: nextPage); // default = getCharacters
  }

  Future<void> refresh() async {
    await getCharacters(page: 1);
  }
}
