
import 'package:equatable/equatable.dart';

class NewsFirebaseEntity extends Equatable {
  final int id;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final String type;
  final String source;
  final int? episodes;
  final String status;
  final bool airing;
  final String duration;
  final String rating;
  final double? score;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  final String imageUrl;
  final String season;
  final int year;
  final List<String> genres;
  final List<String> studios;
  final List<String> producers;
  final List<String> themes;
  final List<String> demographics;
  final List<VoiceActor>? voiceActor;

  const NewsFirebaseEntity({
    required this.id,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.source,
    this.episodes,
    required this.status,
    required this.airing,
    required this.duration,
    required this.rating,
    this.score,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.imageUrl,
    required this.season,
    required this.year,
    required this.genres,
    required this.studios,
    required this.producers,
    required this.themes,
    required this.demographics,
    this.voiceActor,
  });

  factory NewsFirebaseEntity.fromJson(Map<String, dynamic> json) {
    return NewsFirebaseEntity(
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      type: json['type'] ?? '',
      source: json['source'] ?? '',
      episodes: json['episodes'] as int?,
      status: json['status'] ?? '',
      airing: json['airing'] ?? false,
      duration: json['duration'] ?? '',
      rating: json['rating'] ?? '',
      score: (json['score'] != null) ? (json['score'] as num).toDouble() : null,
      popularity: json['popularity'] ?? 0,
      members: json['members'] ?? 0,
      favorites: json['favorites'] ?? 0,
      synopsis: json['synopsis'] ?? '',
      imageUrl: (json['images']?['jpg']?['image_url'] ?? ''),
      season: json['season'] ?? '',
      year: json['year'] ?? 0,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((g) => g['name'].toString())
              .toList() ??
          [],
      studios:
          (json['studios'] as List<dynamic>?)
              ?.map((s) => s['name'].toString())
              .toList() ??
          [],
      producers:
          (json['producers'] as List<dynamic>?)
              ?.map((p) => p['name'].toString())
              .toList() ??
          [],
      themes:
          (json['themes'] as List<dynamic>?)
              ?.map((t) => t['name'].toString())
              .toList() ??
          [],
      demographics:
          (json['demographics'] as List<dynamic>?)
              ?.map((d) => d['name'].toString())
              .toList() ??
          [],
      voiceActor:
          (json['voice_actors'] as List<dynamic>?)
              ?.map((v) => VoiceActor.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': id,
      'title': title,
      'title_english': titleEnglish,
      'title_japanese': titleJapanese,
      'type': type,
      'source': source,
      'episodes': episodes,
      'status': status,
      'airing': airing,
      'duration': duration,
      'rating': rating,
      'score': score,
      'popularity': popularity,
      'members': members,
      'favorites': favorites,
      'synopsis': synopsis,
      'image_url': imageUrl,
      'season': season,
      'year': year,
      'genres': genres,
      'studios': studios,
      'producers': producers,
      'themes': themes,
      'demographics': demographics,
      'voice_actors': voiceActor?.map((v) => v.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    titleEnglish,
    titleJapanese,
    type,
    source,
    episodes,
    status,
    airing,
    duration,
    rating,
    score,
    popularity,
    members,
    favorites,
    synopsis,
    imageUrl,
    season,
    year,
    genres,
    studios,
    producers,
    themes,
    demographics,
    voiceActor,
  ];
}

class VoiceActor extends Equatable {
  final int id;
  final String name;
  final String url;
  final String imageUrl;

  const VoiceActor({
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  factory VoiceActor.fromJson(Map<String, dynamic> json) {
    return VoiceActor(
      id: json['mal_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      imageUrl: json['images']?['jpg']?['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'mal_id': id, 'name': name, 'url': url, 'image_url': imageUrl};
  }

  @override
  List<Object?> get props => [id, name, url, imageUrl];
}
