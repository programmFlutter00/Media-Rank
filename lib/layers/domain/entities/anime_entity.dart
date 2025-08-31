class AnimeEntity {
  final int malId;
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

  AnimeEntity({
    required this.malId,
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
  });

  factory AnimeEntity.fromJson(Map<String, dynamic> json) {
    return AnimeEntity(
      malId: json['mal_id'] ?? 0,
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
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => g['name'].toString())
              .toList() ??
          [],
      studios: (json['studios'] as List<dynamic>?)
              ?.map((s) => s['name'].toString())
              .toList() ??
          [],
      producers: (json['producers'] as List<dynamic>?)
              ?.map((p) => p['name'].toString())
              .toList() ??
          [],
      themes: (json['themes'] as List<dynamic>?)
              ?.map((t) => t['name'].toString())
              .toList() ??
          [],
      demographics: (json['demographics'] as List<dynamic>?)
              ?.map((d) => d['name'].toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
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
    };
  }
}
