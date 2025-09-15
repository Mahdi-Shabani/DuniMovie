import 'package:movie/features/movies/domain/entities/paged_result.dart';
import 'package:movie/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<PagedResult<Movie>> searchMovies(String query, int page);
}
