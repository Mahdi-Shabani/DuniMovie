import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/features/search/data/datasources/local/search_history_local_data_source.dart';

final _historyDsProvider = Provider<SearchHistoryLocalDataSource>((ref) {
  return SearchHistoryLocalDataSource();
});

final searchHistoryNotifierProvider =
    AsyncNotifierProvider<SearchHistoryNotifier, List<String>>(
      SearchHistoryNotifier.new,
    );

class SearchHistoryNotifier extends AsyncNotifier<List<String>> {
  late final SearchHistoryLocalDataSource _ds;

  @override
  Future<List<String>> build() async {
    _ds = ref.read(_historyDsProvider);
    return _ds.load();
  }

  Future<void> add(String query) async {
    final updated = await _ds.add(query);
    state = AsyncData(updated);
  }

  Future<void> clear() async {
    await _ds.clear();
    state = const AsyncData([]);
  }
}
