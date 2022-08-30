import 'package:weather_app/models/safe_convert.dart';

class GetLocationImages {
  final int total;
  final int totalPages;
  final List<ResultsItem> results;

  GetLocationImages({
    this.total = 0,
    this.totalPages = 0,
    required this.results,
  });

  factory GetLocationImages.fromJson(Map<String, dynamic>? json) =>
      GetLocationImages(
        total: asInt(json, 'total'),
        totalPages: asInt(json, 'total_pages'),
        results: asList(json, 'results')
            .map((e) => ResultsItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'total_pages': totalPages,
        'results': results.map((e) => e.toJson()),
      };
}

class ResultsItem {
  final String id;
  final String createdAt;
  final String updatedAt;
  final int width;
  final int height;
  final String color;
  final String blurHash;
  final String altDescription;
  final Urls urls;
  final List<dynamic> categories;
  final int likes;
  final bool likedByUser;
  final List<dynamic> currentUserCollections;
  final String description;

  ResultsItem({
    this.id = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.width = 0,
    this.height = 0,
    this.color = "",
    this.blurHash = "",
    this.altDescription = "",
    required this.urls,
    required this.categories,
    this.likes = 0,
    this.likedByUser = false,
    required this.currentUserCollections,
    this.description = "",
  });

  factory ResultsItem.fromJson(Map<String, dynamic>? json) => ResultsItem(
        id: asString(json, 'id'),
        createdAt: asString(json, 'created_at'),
        updatedAt: asString(json, 'updated_at'),
        width: asInt(json, 'width'),
        height: asInt(json, 'height'),
        color: asString(json, 'color'),
        blurHash: asString(json, 'blur_hash'),
        altDescription: asString(json, 'alt_description'),
        urls: Urls.fromJson(asMap(json, 'urls')),
        categories:
            asList(json, 'categories').map((e) => e.toString()).toList(),
        likes: asInt(json, 'likes'),
        likedByUser: asBool(json, 'liked_by_user'),
        currentUserCollections: asList(json, 'current_user_collections')
            .map((e) => e.toString())
            .toList(),
        description: asString(json, 'description'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'width': width,
        'height': height,
        'color': color,
        'blur_hash': blurHash,
        'alt_description': altDescription,
        'urls': urls.toJson(),
        'categories': categories.map((e) => e),
        'likes': likes,
        'liked_by_user': likedByUser,
        'current_user_collections': currentUserCollections.map((e) => e),
        'description': description,
      };
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;

  Urls({
    this.raw = "",
    this.full = "",
    this.regular = "",
    this.small = "",
    this.thumb = "",
    this.smallS3 = "",
  });

  factory Urls.fromJson(Map<String, dynamic>? json) => Urls(
        raw: asString(json, 'raw'),
        full: asString(json, 'full'),
        regular: asString(json, 'regular'),
        small: asString(json, 'small'),
        thumb: asString(json, 'thumb'),
        smallS3: asString(json, 'small_s3'),
      );

  Map<String, dynamic> toJson() => {
        'raw': raw,
        'full': full,
        'regular': regular,
        'small': small,
        'thumb': thumb,
        'small_s3': smallS3,
      };
}
