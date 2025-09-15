class MovieLite {
  final int id;
  final String title;
  final String poster;
  final String year;
  final double imdbRating;
  final List<String> genres;
  final int? runtimeMinutes;

  const MovieLite({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
    required this.imdbRating,
    this.genres = const [],
    this.runtimeMinutes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'poster': poster,
    'year': year,
    'imdbRating': imdbRating,
    'genres': genres,
    'runtimeMinutes': runtimeMinutes,
  };

  factory MovieLite.fromJson(Map<String, dynamic> json) => MovieLite(
    id: int.tryParse('${json['id']}') ?? 0,
    title: (json['title'] ?? '').toString(),
    poster: (json['poster'] ?? '').toString(),
    year: (json['year'] ?? '').toString(),
    imdbRating: (json['imdbRating'] is num)
        ? (json['imdbRating'] as num).toDouble()
        : double.tryParse('${json['imdbRating']}') ?? 0,
    genres: (json['genres'] as List?)?.map((e) => '$e').toList() ?? const [],
    runtimeMinutes: json['runtimeMinutes'] == null
        ? null
        : int.tryParse('${json['runtimeMinutes']}'),
  );
}
