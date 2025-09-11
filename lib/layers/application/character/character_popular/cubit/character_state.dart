part of 'character_cubit.dart';

enum CharacterStatus { initial, loading, success, failed }
enum CharacterMode { normal, popular, search }

class CharacterState {
  final CharacterStatus status;
  final CharacterMode mode; // 🔹 qo‘shildi
  final List<CharacterEntity> characters;
  final String? error;
  final int currentPage;
  final bool hasMore;

  const CharacterState({
    this.status = CharacterStatus.initial,
    this.mode = CharacterMode.normal, // 🔹 default normal
    this.characters = const [],
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  CharacterState copyWith({
    CharacterStatus? status,
    CharacterMode? mode,
    List<CharacterEntity>? characters,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return CharacterState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      characters: characters ?? this.characters,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
