import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/features/search/presentation/widgets/recent_and_trending_section.dart';
import 'package:movie/features/search/widgets/recent_and_trending_section.dart';

class SearchRecentPage extends StatelessWidget {
  const SearchRecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padForStatus: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: const [
            SizedBox(height: 12),
            RecentAndTrendingSection(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
