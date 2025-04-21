class Media {
  final int id;
  final int? idMal;
  final Title title;
  final String? type;
  final String? format;
  final String? status;
  final Date? startDate;
  final Date? endDate;
  final String? season;
  final int? seasonYear;
  final int? seasonInt;
  final int? episodes;
  final int? duration;
  final int? chapters;
  final int? volumes;
  final String? source;
  final String? countryOfOrigin;
  final bool? isLicensed;
  final bool isAdult;
  final String? description;
  final List<String> synonyms;
  final int? averageScore;
  final int? meanScore;
  final int? popularity;
  final int? trending;
  final int? favourites;
  final List<String> genres;
  final List<Tag> tags;
  final CoverImage coverImage;
  final String? bannerImage;
  final Trailer? trailer;

  Media({
    required this.id,
    this.idMal,
    required this.title,
    this.type,
    this.format,
    this.status,
    this.startDate,
    this.endDate,
    this.season,
    this.seasonYear,
    this.seasonInt,
    this.episodes,
    this.duration,
    this.chapters,
    this.volumes,
    this.source,
    this.countryOfOrigin,
    this.isLicensed,
    required this.isAdult,
    this.description,
    required this.synonyms,
    this.averageScore,
    this.meanScore,
    this.popularity,
    this.trending,
    this.favourites,
    required this.genres,
    required this.tags,
    required this.coverImage,
    this.bannerImage,
    this.trailer,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'],
    idMal: json['idMal'],
    title: Title.fromJson(json['title']),
    type: json['type'],
    format: json['format'],
    status: json['status'],
    startDate:
        json['startDate'] != null ? Date.fromJson(json['startDate']) : null,
    endDate: json['endDate'] != null ? Date.fromJson(json['endDate']) : null,
    season: json['season'],
    seasonYear: json['seasonYear'],
    seasonInt: json['seasonInt'],
    episodes: json['episodes'],
    duration: json['duration'],
    chapters: json['chapters'],
    volumes: json['volumes'],
    source: json['source'],
    countryOfOrigin: json['countryOfOrigin'],
    isLicensed: json['isLicensed'],
    isAdult: json['isAdult'] ?? false,
    description: json['description'],
    synonyms: List<String>.from(json['synonyms'] ?? []),
    averageScore: json['averageScore'],
    meanScore: json['meanScore'],
    popularity: json['popularity'],
    trending: json['trending'],
    favourites: json['favourites'],
    genres: List<String>.from(json['genres'] ?? []),
    tags:
        (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e))
            .toList() ??
        [],
    coverImage: CoverImage.fromJson(json['coverImage']),
    bannerImage: json['bannerImage'],
    trailer: json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'idMal': idMal,
    'title': title.toJson(),
    'type': type,
    'format': format,
    'status': status,
    'startDate': startDate?.toJson(),
    'endDate': endDate?.toJson(),
    'season': season,
    'seasonYear': seasonYear,
    'seasonInt': seasonInt,
    'episodes': episodes,
    'duration': duration,
    'chapters': chapters,
    'volumes': volumes,
    'source': source,
    'countryOfOrigin': countryOfOrigin,
    'isLicensed': isLicensed,
    'isAdult': isAdult,
    'description': description,
    'synonyms': synonyms,
    'averageScore': averageScore,
    'meanScore': meanScore,
    'popularity': popularity,
    'trending': trending,
    'favourites': favourites,
    'genres': genres,
    'tags': tags.map((e) => e.toJson()).toList(),
    'coverImage': coverImage.toJson(),
    'bannerImage': bannerImage,
    'trailer': trailer?.toJson(),
  };
}

class Title {
  final String romaji;
  final String? english;
  final String? native;
  final String? userPreferred;

  Title({required this.romaji, this.english, this.native, this.userPreferred});

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    romaji: json['romaji'],
    english: json['english'],
    native: json['native'],
    userPreferred: json['userPreferred'],
  );

  Map<String, dynamic> toJson() => {
    'romaji': romaji,
    'english': english,
    'native': native,
    'userPreferred': userPreferred,
  };
}

class Date {
  final int? year;
  final int? month;
  final int? day;

  Date({this.year, this.month, this.day});

  factory Date.fromJson(Map<String, dynamic> json) =>
      Date(year: json['year'], month: json['month'], day: json['day']);

  Map<String, dynamic> toJson() => {'year': year, 'month': month, 'day': day};
}

class CoverImage {
  final String large;
  final String medium;
  final String? color;

  CoverImage({required this.large, required this.medium, this.color});

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
    large: json['large'],
    medium: json['medium'],
    color: json['color'],
  );

  Map<String, dynamic> toJson() => {
    'large': large,
    'medium': medium,
    'color': color,
  };
}

class Tag {
  final String name;
  final int? rank;

  Tag({required this.name, this.rank});

  factory Tag.fromJson(Map<String, dynamic> json) =>
      Tag(name: json['name'], rank: json['rank']);

  Map<String, dynamic> toJson() => {'name': name, 'rank': rank};
}

class Trailer {
  final String site;
  final String id;

  Trailer({required this.site, required this.id});

  factory Trailer.fromJson(Map<String, dynamic> json) =>
      Trailer(site: json['site'], id: json['id']);

  Map<String, dynamic> toJson() => {'site': site, 'id': id};
}
