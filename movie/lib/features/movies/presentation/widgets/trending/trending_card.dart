import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String year;

  const TrendingCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 121,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // پوستر
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 121,
              height: 189,
              child: Image.asset(imageAsset, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          // عنوان و سال
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                year,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
