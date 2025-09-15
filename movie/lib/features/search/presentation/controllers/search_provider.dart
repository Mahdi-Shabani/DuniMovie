import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../movies/domain/entities/paged_result.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

final searchResultsProvider = FutureProvider.autoDispose
    .family<PagedResult<Movie>, String>((ref, query) async {
      final usecase = ref.read(searchMoviesUsecaseProvider);
      return usecase(query, page: 1);
    });
