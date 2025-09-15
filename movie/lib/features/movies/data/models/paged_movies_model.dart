import 'package:movie/features/movies/domain/entities/paged_result.dart';
import 'package:movie/features/movies/domain/entities/movie.dart';
import 'movie_model.dart';

class PagedMoviesModel {
  final List<MovieModel> data;
  final PagedMeta meta;

  PagedMoviesModel({required this.data, required this.meta});

  factory PagedMoviesModel.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List? ?? [])
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final m = json['metadata'] as Map<String, dynamic>? ?? {};
    final meta = PagedMeta(
      currentPage: int.tryParse(m['current_page']?.toString() ?? '') ?? 1,
      perPage: int.tryParse(m['per_page']?.toString() ?? '') ?? list.length,
      pageCount: int.tryParse(m['page_count']?.toString() ?? '') ?? 1,
      totalCount:
          int.tryParse(m['total_count']?.toString() ?? '') ?? list.length,
    );

    return PagedMoviesModel(data: list, meta: meta);
  }

  PagedResult<Movie> toEntity() => PagedResult<Movie>(
    data: data.map((e) => e.toEntity()).toList(),
    meta: meta,
  );
}
