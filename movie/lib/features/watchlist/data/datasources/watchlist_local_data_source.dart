import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie/features/watchlist/domain/entities/movie_lite.dart';

class WatchlistLocalDataSource {
  static const _key = 'watchlist_v1';

  Future<List<MovieLite>> load() async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList(_key) ?? const [];
    return list
        .map((s) => MovieLite.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<MovieLite> items) async {
    final sp = await SharedPreferences.getInstance();
    final data = items
        .map((m) => jsonEncode(m.toJson()))
        .toList(growable: false);
    await sp.setStringList(_key, data);
  }

  Future<List<MovieLite>> add(MovieLite item) async {
    final current = await load();
    final filtered = current.where((e) => e.id != item.id).toList();
    filtered.insert(0, item);
    await save(filtered);
    return filtered;
  }

  Future<List<MovieLite>> remove(int id) async {
    final current = await load();
    final filtered = current.where((e) => e.id != id).toList();
    await save(filtered);
    return filtered;
  }

  Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_key);
  }
}
