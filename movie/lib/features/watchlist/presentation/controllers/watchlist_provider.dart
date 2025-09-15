import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/features/watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:movie/features/watchlist/domain/entities/movie_lite.dart';

final watchlistNotifierProvider =
    AsyncNotifierProvider<WatchlistNotifier, List<MovieLite>>(
      WatchlistNotifier.new,
    );

class WatchlistNotifier extends AsyncNotifier<List<MovieLite>> {
  final _ds = WatchlistLocalDataSource();
  Set<int> _ids = {};

  @override
  Future<List<MovieLite>> build() async {
    final data = await _ds.load();
    _ids = data.map((e) => e.id).toSet();
    return data;
  }

  bool exists(int id) => _ids.contains(id);

  Future<void> add(MovieLite m) async {
    final updated = await _ds.add(m);
    _ids = updated.map((e) => e.id).toSet();
    state = AsyncData(updated);
  }

  Future<void> remove(int id) async {
    final updated = await _ds.remove(id);
    _ids = updated.map((e) => e.id).toSet();
    state = AsyncData(updated);
  }

  Future<void> toggle(MovieLite m) async {
    if (exists(m.id)) {
      await remove(m.id);
    } else {
      await add(m);
    }
  }

  Future<void> clear() async {
    await _ds.clear();
    _ids.clear();
    state = const AsyncData([]);
  }
}
