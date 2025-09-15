import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:movie/core/utils/ui_scale.dart';
import 'package:movie/features/watchlist/presentation/controllers/watchlist_provider.dart';
import 'package:movie/features/watchlist/domain/entities/movie_lite.dart';
import 'package:movie/features/movies/presentation/pages/home/home_page.dart';

class WatchlistPage extends ConsumerStatefulWidget {
  const WatchlistPage({super.key});

  @override
  ConsumerState<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends ConsumerState<WatchlistPage> {
  int _tabIndex = 1;

  List<MovieLite> get _samples => const [
    MovieLite(
      id: 101,
      title: 'John Wick: Chapter 4',
      poster: 'assets/images/jhon.png',
      year: '2023',
      imdbRating: 8.5,
      genres: ['Action', 'Thriller', 'Crime'],
      runtimeMinutes: 170,
    ),
    MovieLite(
      id: 102,
      title: 'My Fault',
      poster: 'assets/images/Rectangle 27.png',
      year: '2023',
      imdbRating: 6.7,
      genres: ['Romance', 'Drama'],
      runtimeMinutes: 117,
    ),
    MovieLite(
      id: 103,
      title: 'Flamin\' Hot',
      poster: 'assets/images/Group3.png',
      year: '2023',
      imdbRating: 6.9,
      genres: ['Comedy', 'Drama'],
      runtimeMinutes: 99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const double navSidePadding = 20;
    const double navHeight = 52;
    const double navBottomMargin = 8;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double bottomSafe = MediaQuery.of(context).padding.bottom;

    final async = ref.watch(watchlistNotifierProvider);
    final notifier = ref.read(watchlistNotifierProvider.notifier);

    return AppScaffold(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 48,
                      ),
                      icon: Image.asset(
                        'assets/icons/Vector2.png',
                        width: 22,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Watchlist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        for (final s in _samples) {
                          await notifier.add(s);
                        }
                      },
                      tooltip: 'Add samples',
                      icon: const Icon(Icons.add, color: Colors.white70),
                    ),
                  ],
                ),

                Expanded(
                  child: async.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.white70),
                    ),
                    error: (e, _) => Center(
                      child: Text(
                        'Error: $e',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    data: (items) {
                      if (items.isEmpty) {
                        return Center(
                          child: SizedBox(
                            width: sw(context, 305),
                            height: sh(context, 108),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                'Sorry, You haven’t added\nany movie or TV\nshow to your watchlist',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.only(
                          bottom: navHeight + navBottomMargin + bottomSafe + 16,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final m = items[index];
                          return Dismissible(
                            key: ValueKey(m.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE94242).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            onDismissed: (_) => notifier.remove(m.id),
                            child: _WatchItemCard(
                              movie: m,
                              onRemove: () => notifier.remove(m.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: navSidePadding,
            right: navSidePadding,
            bottom: navBottomMargin + bottomSafe,
            child: AppBottomNav(
              currentIndex: _tabIndex,
              onChanged: (i) async {
                if (i == _tabIndex) return;
                setState(() => _tabIndex = i);

                if (i == 0) {
                  // Home
                  await Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const HomePage()));
                  if (!mounted) return;
                  setState(() => _tabIndex = 1);
                } else if (i == 2) {}
              },
              width: screenWidth - (navSidePadding * 2),
              height: navHeight,
              backgroundColor: const Color(0xFF26253A),
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchItemCard extends StatelessWidget {
  const _WatchItemCard({required this.movie, required this.onRemove});

  final MovieLite movie;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 66,
              height: 96,
              child: _Poster(path: movie.poster),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.year,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.imdbRating.toStringAsFixed(
                        movie.imdbRating % 1 == 0 ? 0 : 1,
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                if (movie.genres.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: movie.genres
                        .map(
                          (g) => Container(
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.9),
                                width: 1.2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              g,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),

          IconButton(
            onPressed: onRemove,
            tooltip: 'Remove',
            icon: const Icon(Icons.delete_outline, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover);
    }
    return Image.asset(path, fit: BoxFit.cover);
  }
}
