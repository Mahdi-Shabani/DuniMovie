import 'package:flutter/material.dart';
import '../trending/trending_card.dart';

class NewReleaseTvSection extends StatelessWidget {
  const NewReleaseTvSection({super.key});

  static const double _posterHeight = 189;
  static const double _gap = 8;
  static const double _textBlock = 22;

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('assets/images/Rectangle 29 (1).png', 'Arnold', 'S1 EP 3'),
      ('assets/images/Rectangle 28 (1).png', 'Silo', 'S1 EP 10'),
      ('assets/images/Group3.png', 'Fubar', 'S1 EP 1'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'New Release - TV Shows',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Text(
              'View all',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: _posterHeight + _gap + _textBlock,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final it = items[index];
              return TrendingCard(imageAsset: it.$1, title: it.$2, year: it.$3);
            },
          ),
        ),
      ],
    );
  }
}
