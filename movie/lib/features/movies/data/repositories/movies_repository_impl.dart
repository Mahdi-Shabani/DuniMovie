import '../../domain/entities/movie.dart';
import '../../domain/entities/paged_result.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/remote/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remote;
  MoviesRepositoryImpl(this.remote);

  @override
  Future<PagedResult<Movie>> searchMovies(String query, int page) {
    return remote.searchMovies(query, page);
  }
}
