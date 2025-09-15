import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryLocalDataSource {
  static const _key = 'search_history';
  static const int _maxItems = 10;

  Future<List<String>> load() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_key) ?? const [];
  }

  Future<void> save(List<String> list) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList(_key, list);
  }

  Future<List<String>> add(String query) async {
    final q = query.trim();
    if (q.isEmpty) return load();

    final sp = await SharedPreferences.getInstance();
    final list = List<String>.from(sp.getStringList(_key) ?? const []);

    list.removeWhere((e) => e.toLowerCase().trim() == q.toLowerCase());
    list.insert(0, q);
    if (list.length > _maxItems) {
      list.removeRange(_maxItems, list.length);
    }
    await sp.setStringList(_key, list);
    return list;
  }

  Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_key);
  }
}
