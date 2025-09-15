import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/features/movies/presentation/widgets/detail/movie_detail_header.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    this.imageAsset = 'assets/images/jhon.png', // یا jhon.jpg
    this.title = 'John Wick: Chapter 4',
  });

  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padForStatus: false, // تصویر تا بالا می‌چسبد
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MovieDetailHeader(
            imageAsset: imageAsset,
            onBack: () => Navigator.of(context).maybePop(),
            onAction: () {}, // بعداً وصل می‌کنیم
          ),

          // عنوان زیر تصویر (بیرون تصویر)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 16),
          // ادامه‌ی جزئیات در مراحل بعدی
        ],
      ),
    );
  }
}
