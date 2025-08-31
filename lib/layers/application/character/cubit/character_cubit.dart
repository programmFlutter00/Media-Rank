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
  final CharacterUsecase getCharactersUseCase;

  CharacterCubit(this.getCharactersUseCase) : super(const CharacterState());
  
  Future<void> getCharacters(String type, {int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(status: CharacterStatus.loading));
    }

    final result = await getCharactersUseCase(type: type, page: page);

    result.fold(
      (error) => emit(state.copyWith(
        status: CharacterStatus.failed,
        error: error,
      )),
      (characters) {
        final allCharacters = page == 1
            ? characters
            : [...state.characters, ...characters];

        emit(state.copyWith(
          status: CharacterStatus.success,
          characters: allCharacters,
          currentPage: page,
          hasMore: characters.isNotEmpty, // agar kelgan data bo‘lsa hasMore true
        ));
      },
    );
  }
}



