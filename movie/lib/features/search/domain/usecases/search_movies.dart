import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../movies/domain/entities/paged_result.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/domain/repositories/movies_repository.dart';
import '../../../movies/domain/providers/movies_providers.dart';

class SearchMovies {
  final MoviesRepository repo;
  SearchMovies(this.repo);

  Future<PagedResult<Movie>> call(String query, {int page = 1}) {
    return repo.searchMovies(query, page);
  }
}

final searchMoviesUsecaseProvider = Provider<SearchMovies>((ref) {
  final repo = ref.read(moviesRepositoryProvider);
  return SearchMovies(repo);
});
