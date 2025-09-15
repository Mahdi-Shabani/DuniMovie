import 'package:movie/features/movies/domain/entities/movie.dart';

class MovieModel {
  final int id;
  final String title;
  final String poster;
  final String year;
  final double imdbRating;

  MovieModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
    required this.imdbRating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    double parseRating(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      final s = v.toString().trim();
      return double.tryParse(s) ?? 0;
    }

    return MovieModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: (json['title'] ?? '').toString(),
      poster: (json['poster'] ?? '').toString(),
      year: (json['year'] ?? '').toString(),
      imdbRating: parseRating(json['imdb_rating']),
    );
  }

  Movie toEntity() => Movie(
    id: id,
    title: title,
    poster: poster,
    year: year,
    imdbRating: imdbRating,
  );
}
