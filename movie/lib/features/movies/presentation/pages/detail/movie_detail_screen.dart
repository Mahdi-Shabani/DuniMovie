import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/utils/ui_scale.dart';
import 'package:movie/features/movies/presentation/widgets/detail/movie_detail_header.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    this.imageAsset = 'assets/images/jhon.png', // یا jhon.jpg
    this.title = 'John Wick: Chapter 4',
    this.runtimeMinutes = 170,
    // چیپ‌ها (تصویر) ــ مسیرها را با فایل‌های خودت هماهنگ کن
    this.chipAction = 'assets/icons/Frame (1).png',
    this.chipThriller = 'assets/icons/Frame (2).png',
    this.chipCrime = 'assets/icons/Frame (3).png',
    // متن توضیحات
    this.overview =
        'With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. '
        'But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances '
        'across the globe and forces that turn old friends into foes.',
    // جزئیات
    this.country = 'United States',
    this.genre = 'Drama, Science Fiction',
    this.dateRelease = 'May 05 2023',
    this.production = 'AMC Studios',
  });

  final String imageAsset;
  final String title;
  final int runtimeMinutes;

  final String chipAction;
  final String chipThriller;
  final String chipCrime;

  final String overview;

  final String country;
  final String genre;
  final String dateRelease;
  final String production;

  @override
  Widget build(BuildContext context) {
    const surface = Color(0xFF34324A);

    return AppScaffold(
      showStatusOverlay:
          false, // STATUS سراسری خاموش؛ داخل هدر نمایش داده می‌شود
      padForStatus: false,
      child: ListView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + sh(context, 16),
        ),
        children: [
          MovieDetailHeader(
            imageAsset: imageAsset,
            onBack: () => Navigator.of(context).maybePop(),
            onAction: () {},
            showStatusOverlay: true,
          ),

          Container(
            color: surface,
            padding: EdgeInsets.fromLTRB(
              sw(context, 16),
              sh(context, 12),
              sw(context, 16),
              sh(context, 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sp(context, 22),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: sh(context, 8)),

                // چیپ‌های تصویری + زمان (با Wrap تا روی هر مدل خراب نشه)
                Wrap(
                  spacing: sw(context, 12),
                  runSpacing: sh(context, 8),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _ChipImg(path: chipAction, height: sh(context, 32)),
                    _ChipImg(path: chipThriller, height: sh(context, 32)),
                    _ChipImg(path: chipCrime, height: sh(context, 32)),
                    // زمان (اگر جا نشه خودکار میره خط بعدی)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: sp(context, 20),
                          color: Colors.white70,
                        ),
                        SizedBox(width: sw(context, 8)),
                        Text(
                          _fmtRuntime(runtimeMinutes),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sp(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: sh(context, 10)),

                // ردیف سال + امتیاز + تعداد ریویو — 450K Reviews کنار 8.5
                _InfoRow(
                  year: '2023',
                  rating: 8.5,
                  reviewsText: '450K Reviews',
                ),

                SizedBox(height: sh(context, 16)),

                // توضیحات
                Text(
                  overview,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sp(context, 18),
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: sh(context, 16)),

                // Details بدون حاشیه
                _DetailsCard(
                  country: country,
                  genre: genre,
                  dateRelease: dateRelease,
                  production: production,
                ),

                SizedBox(height: sh(context, 16)),

                // Top Cast (با Wrap تا هرجا نیاز بود بشکنه)
                Text(
                  'Top Cast',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sp(context, 16),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: sh(context, 10)),

                Wrap(
                  spacing: sw(context, 16),
                  runSpacing: sh(context, 12),
                  children: const [
                    _CastItem(
                      asset: 'assets/images/Mask1.png',
                      name: 'Keanu Reeves',
                    ),
                    _CastItem(
                      asset: 'assets/images/Mask2.png',
                      name: 'Donnie Yen',
                    ),
                    _CastItem(
                      asset: 'assets/images/Mask3.png',
                      name: 'Bill Skarsgard',
                    ),
                    _CastItem(
                      asset: 'assets/images/Mask4.png',
                      name: 'Ian McShane',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtRuntime(int minutes) {
    if (minutes <= 0) return '';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0 && m > 0) return '$h hr $m min';
    if (h > 0) return '$h hr';
    return '$m min';
  }
}

class _ChipImg extends StatelessWidget {
  const _ChipImg({required this.path, required this.height});
  final String path;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height, // ارتفاع ثابت
      fit: BoxFit.contain, // عرض بر اساس نسبت خود فایل
      filterQuality: FilterQuality.high,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.year,
    required this.rating,
    required this.reviewsText,
  });

  final String year;
  final double rating;
  final String reviewsText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sh(context, 44),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: sp(context, 20),
            color: Colors.white70,
          ),
          SizedBox(width: sw(context, 10)),
          Text(
            year,
            style: TextStyle(
              color: Colors.white,
              fontSize: sp(context, 16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: sw(context, 24)),
          Icon(
            Icons.star_rounded,
            size: sp(context, 20),
            color: Colors.white70,
          ),
          SizedBox(width: sw(context, 10)),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: Colors.white,
              fontSize: sp(context, 16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: sw(context, 16)),
          Flexible(
            child: Text(
              reviewsText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: sp(context, 16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({
    required this.country,
    required this.genre,
    required this.dateRelease,
    required this.production,
  });

  final String country;
  final String genre;
  final String dateRelease;
  final String production;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: sh(context, 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: sp(context, 14.5),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: sh(context, 8)),
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FixedColumnWidth(14),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              _row(context, 'Country', country),
              _row(context, 'Genre', genre),
              _row(context, 'Date Release', dateRelease),
              _row(context, 'Production', production),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _row(BuildContext context, String label, String value) {
    final labelStyle = TextStyle(
      color: Colors.white,
      fontSize: sp(context, 14),
      fontWeight: FontWeight.w600,
    );
    final valueStyle = TextStyle(
      color: Colors.white,
      fontSize: sp(context, 14),
      fontWeight: FontWeight.w500,
    );

    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: sh(context, 6)),
          child: Text(label, style: labelStyle),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: sh(context, 6)),
          child: Text(
            ':',
            style: TextStyle(color: Colors.white, fontSize: sp(context, 14)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: sh(context, 6)),
          child: Text(
            value,
            style: valueStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CastItem extends StatelessWidget {
  const _CastItem({required this.asset, required this.name});
  final String asset;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sw(context, 72),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: sw(context, 56),
            height: sw(context, 56),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(asset, fit: BoxFit.cover),
          ),
          SizedBox(height: sh(context, 6)),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: sp(context, 12),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
