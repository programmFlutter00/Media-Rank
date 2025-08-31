class CharacterEntity {
  final int malId;
  final String? url;
  final String name;
  final String? nameKanji;
  final List<String>? nicknames;
  final int? favorites;
  final String? about;
  final CharacterImages? images;

  CharacterEntity({
    required this.malId,
    this.url,
    required this.name,
    this.nameKanji,
    this.nicknames,
    this.favorites,
    this.about,
    this.images,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      malId: (json['mal_id'] as num?)?.toInt() ?? 0,
      url: json['url'] as String?,
      name: json['name'] as String? ?? 'Unknown',
      nameKanji: json['name_kanji'] as String?,
      nicknames: (json['nicknames'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      favorites: (json['favorites'] as num?)?.toInt(),
      about: json['about'] as String?,
      images: json['images'] != null
          ? CharacterImages.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'url': url,
        'name': name,
        'name_kanji': nameKanji,
        'nicknames': nicknames,
        'favorites': favorites,
        'about': about,
        'images': images?.toJson(),
      };
}

class CharacterImages {
  final ImageSet? jpg;
  final ImageSet? webp;

  CharacterImages({this.jpg, this.webp});

  factory CharacterImages.fromJson(Map<String, dynamic> json) {
    return CharacterImages(
      jpg: json['jpg'] != null 
          ? ImageSet.fromJson(json['jpg'] as Map<String, dynamic>) 
          : null,
      webp: json['webp'] != null 
          ? ImageSet.fromJson(json['webp'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'jpg': jpg?.toJson(),
        'webp': webp?.toJson(),
      };
}

class ImageSet {
  final String? imageUrl;
  final String? smallImageUrl;

  ImageSet({
    this.imageUrl,
    this.smallImageUrl,
  });

  factory ImageSet.fromJson(Map<String, dynamic> json) {
    return ImageSet(
      imageUrl: json['image_url'] as String?,
      smallImageUrl: json['small_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'small_image_url': smallImageUrl,
      };
}

// Response wrapper for paginated results
class CharacterResponse {
  final List<CharacterEntity> data;
  final Pagination? pagination;

  CharacterResponse({
    required this.data,
    this.pagination,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CharacterEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'pagination': pagination?.toJson(),
      };
}

class Pagination {
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalCount;

  Pagination({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.itemsPerPage,
    this.totalCount,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: (json['last_visible_page'] as num?)?.toInt(),
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: (json['current_page'] as num?)?.toInt(),
      itemsPerPage: (json['items_per_page'] as num?)?.toInt(),
      totalCount: (json['total_count'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'last_visible_page': lastVisiblePage,
        'has_next_page': hasNextPage,
        'current_page': currentPage,
        'items_per_page': itemsPerPage,
        'total_count': totalCount,
      };
}
