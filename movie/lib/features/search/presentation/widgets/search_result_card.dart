import 'package:flutter/material.dart';
import 'package:movie/core/utils/web_image_proxy.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.rating,
    this.runtimeMinutes, // اختیاری؛ اگر null باشد ردیف زمان مخفی می‌شود
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final String year;
  final double rating;
  final int? runtimeMinutes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // اندازه دقیق طبق طرح
    const double cardHeight = 147;
    const double posterWidth = 98; // تقریبی برای نسبت تصویر در کارت 147px

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: cardHeight,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.9),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // پوستر
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  webImageUrl(imageUrl),
                  width: posterWidth,
                  height: cardHeight - 16,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: posterWidth,
                    color: Colors.white12,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white38,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // متن‌ها
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ردیف سال + امتیاز
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          year,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          rating.toStringAsFixed(
                            rating.truncateToDouble() == rating ? 0 : 1,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // ردیف مدت‌زمان (اختیاری)
                    if (runtimeMinutes != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatRuntime(runtimeMinutes!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatRuntime(int minutes) {
    if (minutes <= 0) return '';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0 && m > 0) return '$h hr $m min';
    if (h > 0) return '$h hr';
    return '$m min';
  }
}
