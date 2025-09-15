import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/features/search/presentation/controllers/search_history_provider.dart';
import 'package:movie/features/search/presentation/pages/search_loading_page.dart';

class RecentAndTrendingSection extends ConsumerWidget {
  const RecentAndTrendingSection({super.key});

  static const _trending = ['Robots', 'Hypnotic', 'The Mother', 'The covenant'];

  void _go(BuildContext context, WidgetRef ref, String q) {
    ref.read(searchHistoryNotifierProvider.notifier).add(q);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SearchLoadingPage(initialQuery: q)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(searchHistoryNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () =>
                  ref.read(searchHistoryNotifierProvider.notifier).clear(),
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        async.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (items) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final q in items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: GestureDetector(
                    onTap: () => _go(context, ref, q),
                    child: Text(
                      q,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Trending Searches',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final t in _trending)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: GestureDetector(
                  onTap: () => _go(context, ref, t),
                  child: Text(
                    t,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
