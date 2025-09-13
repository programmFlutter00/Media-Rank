import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_rank/layers/domain/entities/anime_character_entity.dart';
import 'package:media_rank/layers/domain/usecases/anime_usecase.dart';

part 'anime_character_state.dart';

class AnimeCharacterCubit extends Cubit<AnimeCharacterState> {
  final AnimeUsecase _usecase;

  AnimeCharacterCubit(this._usecase) : super(const AnimeCharacterState());

  /// API orqali personajlarni olish
  Future<void> getCharacters(int animeId) async {
    emit(state.copyWith(status: AnimeCharacterStatus.loading, error: null));

    final result = await _usecase.getAnimeCharacters(animeId: animeId);

    result.fold(
      (error) => emit(
        state.copyWith(status: AnimeCharacterStatus.failed, error: error),
      ),
      (list) => emit(
        state.copyWith(
          status: AnimeCharacterStatus.success,
          characters: list,
          error: null,
        ),
      ),
    );
  }

  /// Refresh qilish uchun
  Future<void> refresh(int animeId) async {
    await getCharacters(animeId);
  }
}
