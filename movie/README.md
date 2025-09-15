
- اپ فقط در بخش جست‌وجو به API متصل است (moviesapi.ir). بقیه قابلیت‌ها مثل Watchlist کاملاً لوکال‌اند.
- معماری لایه‌ای (Data/Domain/Presentation) + MVVM در UI، مدیریت حالت با Riverpod، شبکه با Dio.
- وب: به‌خاطر CORS تصویر پوسترها از طریق یک پراکسی عمومی بازنویسی می‌شوند.

Tech stack  (پکیج‌ها)
- Dio (شبکه)
- Riverpod (State management)
- SharedPreferences (لوکال Watchlist)
- Flutter (Dark theme)
- Optional (Web): images.weserv.nl برای پروکسی تصویر

ProviderScope در main
- اپ باید داخل ProviderScope بالا بیاید تا Riverpod کار کند.

اتصال به API (جست‌وجو)
- Endpointها:
  - Search: GET https://moviesapi.ir/api/v1/movies?q=<QUERY>&page=<N>
  - Detail (در صورت استفاده بعدی): GET https://moviesapi.ir/api/v1/movies/{id}

Dio + Provider
- lib/core/network/endpoints.dart
```dart
class Endpoints {
  static const baseUrl = 'https://moviesapi.ir/api/v1';
  static const movies = '/movies';
  static String byId(int id) => '/movies/$id';
}
```
- lib/core/network/dio_client.dart
```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'endpoints.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );
  return dio;
});
```

مدل‌ها 
- lib/features/movies/data/models/movie_model.dart
```dart
import '../../domain/entities/movie.dart';

class MovieModel {
  final int id;
  final String title;
  final String poster;
  final String year;
  final double imdbRating;

  MovieModel({required this.id, required this.title, required this.poster, required this.year, required this.imdbRating});

  factory MovieModel.fromJson(Map<String, dynamic> j) => MovieModel(
    id: int.tryParse('${j['id']}') ?? 0,
    title: (j['title'] ?? '').toString(),
    poster: (j['poster'] ?? '').toString(),
    year: (j['year'] ?? '').toString(),
    imdbRating: j['imdb_rating'] is num ? (j['imdb_rating'] as num).toDouble() : double.tryParse('${j['imdb_rating']}') ?? 0,
  );

  Movie toEntity() => Movie(id: id, title: title, poster: poster, year: year, imdbRating: imdbRating);
}
```
- lib/features/movies/data/models/paged_movies_model.dart
```dart
import '../../domain/entities/paged_result.dart';
import '../../domain/entities/movie.dart';
import 'movie_model.dart';

class PagedMoviesModel {
  final List<MovieModel> data;
  final PagedMeta meta;

  PagedMoviesModel({required this.data, required this.meta});

  factory PagedMoviesModel.fromJson(Map<String, dynamic> j) {
    final list = (j['data'] as List? ?? []).map((e) => MovieModel.fromJson(e)).toList();
    final m = j['metadata'] as Map<String, dynamic>? ?? {};
    return PagedMoviesModel(
      data: list,
      meta: PagedMeta(
        currentPage: int.tryParse('${m['current_page']}') ?? 1,
        perPage: int.tryParse('${m['per_page']}') ?? list.length,
        pageCount: int.tryParse('${m['page_count']}') ?? 1,
        totalCount: int.tryParse('${m['total_count']}') ?? list.length,
      ),
    );
  }

  PagedResult<Movie> toEntity() => PagedResult<Movie>(data: data.map((e) => e.toEntity()).toList(), meta: meta);
}
```

Remote DataSource + Repository + UseCase
- lib/features/movies/data/datasources/remote/movies_remote_data_source.dart
```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/endpoints.dart';
import '../../models/paged_movies_model.dart';
import '../../../domain/entities/paged_result.dart';
import '../../../domain/entities/movie.dart';

class MoviesRemoteDataSource {
  final Dio _dio;
  MoviesRemoteDataSource(this._dio);

  Future<PagedResult<Movie>> search(String q, int page) async {
    final res = await _dio.get(Endpoints.movies, queryParameters: {'q': q, 'page': page});
    return PagedMoviesModel.fromJson(res.data as Map<String, dynamic>).toEntity();
  }
}

final moviesRemoteDataSourceProvider = Provider((ref) => MoviesRemoteDataSource(ref.read(dioProvider)));
```
- lib/features/movies/domain/repositories/movies_repository.dart
```dart
import '../entities/paged_result.dart';
import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<PagedResult<Movie>> search(String q, int page);
}
```
- lib/features/movies/data/repositories/movies_repository_impl.dart
```dart
import '../../domain/entities/movie.dart';
import '../../domain/entities/paged_result.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/remote/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remote;
  MoviesRepositoryImpl(this.remote);

  @override
  Future<PagedResult<Movie>> search(String q, int page) => remote.search(q, page);
}
```
- lib/features/search/domain/usecases/search_movies.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../movies/domain/entities/paged_result.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/domain/repositories/movies_repository.dart';
import '../../../movies/data/repositories/movies_repository_impl.dart';
import '../../../movies/data/datasources/remote/movies_remote_data_source.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl(ref.read(moviesRemoteDataSourceProvider));
});

class SearchMovies {
  final MoviesRepository repo;
  SearchMovies(this.repo);
  Future<PagedResult<Movie>> call(String q, {int page = 1}) => repo.search(q, page);
}

final searchMoviesUsecaseProvider = Provider((ref) => SearchMovies(ref.read(moviesRepositoryProvider)));
```

Provider جست‌وجو + صفحه نتایج
- lib/features/search/presentation/controllers/search_provider.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../movies/domain/entities/paged_result.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

final searchResultsProvider = FutureProvider.autoDispose.family<PagedResult<Movie>, String>((ref, query) {
  final usecase = ref.read(searchMoviesUsecaseProvider);
  return usecase(query, page: 1);
});
```
- lib/features/search/presentation/pages/search_results_page.dart (استفاده)
```dart
//  build:
final async = ref.watch(searchResultsProvider(query));
Expanded(
  child: async.when(
    loading: () => const RotatingAssetLoader(assetPath: 'assets/icons/Group0.png', size: 44),
    error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
    data: (paged) {
      if (paged.data.isEmpty) { /* NoResult or  Empty */ }
      return ListView.separated(
        itemCount: paged.data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final m = paged.data[i];
          return SearchResultCard(
            imageUrl: m.poster, //  web_image_url
            title: m.title,
            year: m.year,
            rating: m.imdbRating,
          );
        },
      );
    },
  ),
);
```

حل مشکل تصاویر روی Web (CORS)
- lib/core/utils/web_image_proxy.dart
```dart
import 'package:flutter/foundation.dart';

String webImageUrl(String url) {
  if (!kIsWeb || url.isEmpty) return url;
  final u = Uri.tryParse(url);
  if (u == null) return url;
  final hostPath = '${u.host}${u.path}${u.hasQuery ? '?${u.query}' : ''}';
  return 'https://images.weserv.nl/?url=$hostPath';
}
```
- در کارت‌ها/تصاویر شبکه روی Web از webImageUrl(url) استفاده کن.

Watchlist کاملاً لوکال (SharedPreferences)
- مدل: MovieLite (id, title, poster, year, imdbRating, genres?, runtime?)
- DataSource: load/save/add/remove/clear
- Provider: AsyncNotifier با متدهای add/remove/toggle/exists
- UI:
  - قلب روی کارت‌ها: exists(id) → ظاهر قلب، onTap → toggle(MovieLite)
  - صفحه Watchlist: ref.watch(...) → لیست محلی؛ حذف با swipe یا آیکن سطل
  - Empty-state و ناوبری به جزئیات (در صورت نیاز) با id

