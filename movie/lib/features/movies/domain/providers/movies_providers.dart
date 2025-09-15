import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/features/movies/domain/repositories/movies_repository.dart';
import 'package:movie/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movie/features/movies/data/datasources/remote/movies_remote_data_source.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  final remote = ref.read(moviesRemoteDataSourceProvider);
  return MoviesRepositoryImpl(remote);
});
