import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/widgets/bottom_nav/app_bottom_nav.dart';
import 'package:movie/features/movies/presentation/pages/home/home_page.dart';
import 'package:movie/features/watchlist/presentation/pages/watchlist_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double headerH = w * (263 / 390);
    final double safeTop = MediaQuery.of(context).padding.top;

    const double navSidePadding = 20;
    const double navHeight = 52;
    const double navBottomMargin = 8;
    final double bottomSafe = MediaQuery.of(context).padding.bottom;

    return AppScaffold(
      showStatusOverlay: true,
      padForStatus: false,
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              bottom: navHeight + navBottomMargin + bottomSafe + 16,
            ),
            children: [
              SizedBox(
                height: headerH,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/icons/Rectangle1.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),

                    Positioned(
                      top: safeTop + 24,
                      left: 12,
                      child: IconButton(
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
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -36,
                      child: Center(
                        child: Image.asset(
                          'assets/icons/Component1.png',
                          width: 96,
                          height: 96,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 194,
                        height: 28,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            'Laiba Ahmar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    Center(
                      child: SizedBox(
                        width: 274,
                        height: 20,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            'youremail@domain.com   +01 234 567 89',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 342),
                      child: AspectRatio(
                        aspectRatio: 342 / 121,
                        child: Image.asset(
                          'assets/icons/Group67.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  await Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const HomePage()));
                  if (!mounted) return;
                  setState(() => _tabIndex = 2);
                } else if (i == 1) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WatchlistPage()),
                  );
                  if (!mounted) return;
                  setState(() => _tabIndex = 2);
                }
              },
              width: w - (navSidePadding * 2),
              height: navHeight,
              backgroundColor: const Color(0xFF26253A),
            ),
          ),
        ],
      ),
    );
  }
}
