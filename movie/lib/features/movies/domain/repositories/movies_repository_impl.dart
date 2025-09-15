import 'package:movie/features/movies/domain/entities/movie.dart';
import 'package:movie/features/movies/domain/entities/paged_result.dart';
import 'package:movie/features/movies/domain/repositories/movies_repository.dart';
import 'package:movie/features/movies/data/datasources/remote/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remote;
  MoviesRepositoryImpl(this.remote);

  @override
  Future<PagedResult<Movie>> searchMovies(String query, int page) {
    return remote.searchMovies(query, page);
  }
}
