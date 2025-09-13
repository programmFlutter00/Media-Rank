import 'package:media_rank/layers/domain/entities/firebase/anime_firebase_entity.dart';

import '../entities/anime_entity.dart';

extension AnimeEntityX on AnimeEntity {
  NewsFirebaseEntity toFirebaseEntity() {
    return NewsFirebaseEntity(
      id: malId,
      title: title,
      titleEnglish: titleEnglish,
      titleJapanese: titleJapanese,
      type: type,
      source: source,
      episodes: episodes,
      status: status,
      airing: airing,
      duration: duration,
      rating: rating,
      score: score,
      popularity: popularity,
      members: members,
      favorites: favorites,
      synopsis: synopsis,
      imageUrl: imageUrl,
      season: season,
      year: year,
      genres: genres,
      studios: studios,
      producers: producers,
      themes: themes,
      demographics: demographics,
      voiceActor: [], // API da yo‘q, shuning uchun bo‘sh
    );
  }
}
