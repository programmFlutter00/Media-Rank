import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int malId;
  final String name;
  final String url;
  final String imageUrl;

  const CharacterEntity({
    required this.malId,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      malId: json['mal_id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      imageUrl: json['images']?['jpg']?['image_url'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [malId, name, url, imageUrl];
}

class VoiceActorEntity extends Equatable {
  final int malId;
  final String name;
  final String language;
  final String url;
  final String imageUrl;

  const VoiceActorEntity({
    required this.malId,
    required this.name,
    required this.language,
    required this.url,
    required this.imageUrl,
  });

  factory VoiceActorEntity.fromJson(Map<String, dynamic> json) {
    final person = json['person'] as Map<String, dynamic>;
    return VoiceActorEntity(
      malId: person['mal_id'] as int,
      name: person['name'] as String,
      language: json['language'] as String,
      url: person['url'] as String,
      imageUrl: person['images']?['jpg']?['image_url'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [malId, name, language, url, imageUrl];
}

class AnimeCharacterEntity extends Equatable {
  final CharacterEntity character;
  final String role;
  final int favorites;
  final List<VoiceActorEntity> voiceActors;

  const AnimeCharacterEntity({
    required this.character,
    required this.role,
    required this.favorites,
    required this.voiceActors,
  });

  factory AnimeCharacterEntity.fromJson(Map<String, dynamic> json) {
    final character = CharacterEntity.fromJson(json['character']);
    final role = json['role'] as String;
    final favorites = json['favorites'] as int;
    final voiceActorsJson = json['voice_actors'] as List<dynamic>? ?? [];
    final voiceActors = voiceActorsJson
        .map((v) => VoiceActorEntity.fromJson(v as Map<String, dynamic>))
        .toList();

    return AnimeCharacterEntity(
      character: character,
      role: role,
      favorites: favorites,
      voiceActors: voiceActors,
    );
  }

  @override
  List<Object?> get props => [character, role, favorites, voiceActors];
}
