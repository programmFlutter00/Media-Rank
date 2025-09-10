part of 'anime_character_cubit.dart';


enum AnimeCharacterStatus { initial, loading, success, failed }

class AnimeCharacterState extends Equatable {
  final AnimeCharacterStatus status;
  final List<AnimeCharacterEntity> characters;
  final String? error;

  const AnimeCharacterState({
    this.status = AnimeCharacterStatus.initial,
    this.characters = const [],
    this.error,
  });

  AnimeCharacterState copyWith({
    AnimeCharacterStatus? status,
    List<AnimeCharacterEntity>? characters,
    String? error,
  }) {
    return AnimeCharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, characters, error];
}
