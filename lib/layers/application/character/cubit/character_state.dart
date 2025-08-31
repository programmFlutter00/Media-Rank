part of 'character_cubit.dart';


enum CharacterStatus { initial, loading, success, failed }

class CharacterState {
  final CharacterStatus status;
  final List<CharacterEntity> characters;
  final String? error;
  final int currentPage;
  final bool hasMore;

  const CharacterState({
    this.status = CharacterStatus.initial,
    this.characters = const [],
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  CharacterState copyWith({
    CharacterStatus? status,
    List<CharacterEntity>? characters,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
