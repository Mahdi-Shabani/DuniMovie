import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:movie/features/movies/presentation/widgets/search/movie_search_bar.dart';
import 'package:movie/features/movies/presentation/widgets/filters/category_chips.dart';
import 'package:movie/features/movies/presentation/widgets/trending/trending_section.dart';
import 'package:movie/features/movies/presentation/widgets/new_releases/new_release_movies_section.dart';
import 'package:movie/features/movies/presentation/widgets/new_releases/new_release_tv_section.dart';
import 'package:movie/features/movies/presentation/widgets/recommended/recommended_section.dart';
import 'package:movie/features/search/presentation/pages/search_loading_page.dart';
import 'package:movie/features/movies/presentation/pages/detail/movie_detail_screen.dart';
import 'package:movie/features/watchlist/presentation/pages/watchlist_page.dart';
import 'package:movie/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    const double navSidePadding = 20;
    const double navHeight = 52;
    const double navBottomMargin = 8;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double bottomSafe = MediaQuery.of(context).padding.bottom;
    final double listBottomPadding =
        navHeight + navBottomMargin + bottomSafe + 16;

    return AppScaffold(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: EdgeInsets.only(bottom: listBottomPadding),
              children: [
                SizedBox(
                  height: 28,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 28,
                        child: Image.asset(
                          'assets/icons/Vector.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 20,
                        height: 23,
                        child: Image.asset(
                          'assets/icons/Vector(1).png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                MovieSearchBar(
                  onSearch: (query) {
                    if (query.trim().isEmpty) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SearchLoadingPage(initialQuery: query),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),

                const CategoryChipsRow(),
                const SizedBox(height: 16),

                const Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MovieDetailScreen(
                          imageAsset: 'assets/images/jhon.png',
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 350 / 211,
                      child: Image.asset(
                        'assets/images/jhon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const TrendingSection(),
                const SizedBox(height: 16),
                const NewReleaseMoviesSection(),
                const SizedBox(height: 16),
                const NewReleaseTvSection(),
                const SizedBox(height: 16),
                const RecommendedSection(),
              ],
            ),
          ),

          // نوار پایین
          Positioned(
            left: navSidePadding,
            right: navSidePadding,
            bottom: navBottomMargin + bottomSafe,
            child: AppBottomNav(
              currentIndex: _tabIndex,
              onChanged: (i) async {
                if (i == 0) {
                  if (_tabIndex != 0) setState(() => _tabIndex = 0);
                  return;
                }
                if (i == 1) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WatchlistPage()),
                  );
                  if (!mounted) return;
                  setState(() => _tabIndex = 0);
                  return;
                }
                if (i == 2) {
                  // Profile → بعد از برگشت، آیکن Home سفید بماند
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  );
                  if (!mounted) return;
                  setState(() => _tabIndex = 0);
                  return;
                }
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
