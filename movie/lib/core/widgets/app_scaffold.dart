import 'package:flutter/material.dart';
import 'status_overlay.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showStatusOverlay = true, // پیش‌فرض: نمایش STATUS در همه صفحات
    this.padForStatus = true, // پیش‌فرض: محتوا زیر STATUS قرار بگیرد
  });

  final Widget child;
  final Color? backgroundColor;
  final bool showStatusOverlay;
  final bool padForStatus;

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;
    final overlayPad = showStatusOverlay && padForStatus
        ? (safeTop + StatusOverlay.kBarHeight)
        : 0.0;

    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // محتوای صفحه با فاصله از زیر STATUS (در صورت نیاز)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: overlayPad),
              child: child,
            ),
          ),
          // STATUS ثابت روی همه صفحات (در صورت نیاز)
          if (showStatusOverlay)
            const Positioned(top: 0, left: 0, right: 0, child: StatusOverlay()),
        ],
      ),
    );
  }
}
