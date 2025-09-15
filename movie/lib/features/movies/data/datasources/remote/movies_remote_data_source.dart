import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/core/network/dio_client.dart';
import 'package:movie/core/network/endpoints.dart';
import 'package:movie/features/movies/domain/entities/paged_result.dart';
import 'package:movie/features/movies/domain/entities/movie.dart';
import 'package:movie/features/movies/data/models/paged_movies_model.dart';

class MoviesRemoteDataSource {
  final Dio _dio;
  MoviesRemoteDataSource(this._dio);

  Future<PagedResult<Movie>> searchMovies(String query, int page) async {
    final res = await _dio.get(
      Endpoints.movies,
      queryParameters: {'q': query, 'page': page},
    );
    final model = PagedMoviesModel.fromJson(res.data as Map<String, dynamic>);
    return model.toEntity();
  }
}

final moviesRemoteDataSourceProvider = Provider<MoviesRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return MoviesRemoteDataSource(dio);
});
