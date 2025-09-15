import 'package:flutter/material.dart';

class NowPlayingCard extends StatelessWidget {
  final bool showTitle; // اگر تصویرت خودش عنوان دارد، این را false بگذار
  final String title;

  const NowPlayingCard({
    super.key,
    this.showTitle = true,
    this.title = 'John Wick: Chapter 4',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // رادیوس مطابق طرح
      child: AspectRatio(
        aspectRatio: 350 / 211, // ابعاد کارت
        child: Stack(
          children: [
            // تصویر پس‌زمینه
            Positioned.fill(
              child: Image.asset(
                'assets/images/Group.png', // اگر jpg است، پسوند را تغییر بده
                fit: BoxFit.cover,
              ),
            ),

            // گرادیان خیلی ملایم فقط برای خوانایی (خیلی کمتر از قبل)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // بج HD بالا-چپ
            Positioned(
              top: 8,
              left: 8,
              child: _Badge(
                color: const Color(0xFFE94242),
                child: const Text(
                  'HD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),

            // بج امتیاز بالا-راست
            Positioned(
              top: 8,
              right: 8,
              child: _Badge(
                color: const Color(0xFFE94242),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.star_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      '8.5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // عنوان (اختیاری) - اگر تصویرت خودش عنوان دارد، showTitle=false
            if (showTitle)
              Positioned(
                left: 16,
                bottom: 14,
                right: 16,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // کمی کوچکتر تا به طرح نزدیک‌تر شود
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 6,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Color color;
  final Widget child;
  const _Badge({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
