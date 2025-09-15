import 'package:flutter/material.dart';

class StatusOverlay extends StatelessWidget {
  const StatusOverlay({super.key});

  // ارتفاع محتوای استاتوس (تقریب 44px)
  static const double kBarHeight = 44;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final safeTop = MediaQuery.of(context).padding.top;
    final totalH = safeTop + kBarHeight;

    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: w,
        height: totalH,
        child: Image.asset(
          'assets/icons/STATUS.png', // اگر مسیر/نام فرق دارد اصلاح کن
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
