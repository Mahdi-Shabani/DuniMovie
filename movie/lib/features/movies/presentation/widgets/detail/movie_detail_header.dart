import 'package:flutter/material.dart';
import 'package:movie/core/utils/ui_scale.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader({
    super.key,
    this.imageAsset = 'assets/images/jhon.png',
    this.onBack,
    this.onAction,
    this.showStatusOverlay = true,
  });

  final String imageAsset;
  final VoidCallback? onBack;
  final VoidCallback? onAction;
  final bool showStatusOverlay;

  @override
  Widget build(BuildContext context) {
    final double headerHeight = sh(context, 341);
    final double overshoot = sh(context, 16);
    final double safeTop = MediaQuery.of(context).padding.top;

    final double iconsTop = safeTop + sh(context, 72);
    final double iconsSide = sw(context, 24);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(sw(context, 24)),
        bottomRight: Radius.circular(sw(context, 24)),
      ),
      child: SizedBox(
        height: headerHeight + safeTop + overshoot,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              top: -(safeTop + overshoot),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.25),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (showStatusOverlay)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  ignoring: true,
                  child: SizedBox(
                    height: safeTop + sh(context, 44),
                    child: Image.asset(
                      'assets/icons/STATUS.png',
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

            Positioned(
              top: iconsTop,
              left: iconsSide,
              right: iconsSide,
              child: Row(
                children: [
                  // Back
                  IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    tooltip: 'Back',
                    splashRadius: sw(context, 24),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: sw(context, 48),
                      minHeight: sw(context, 48),
                    ),
                    icon: Image.asset(
                      'assets/icons/Vector2.png',
                      width: sw(context, 22),
                      height: sh(context, 20),
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: onAction,
                    tooltip: 'Action',
                    splashRadius: sw(context, 24),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: sw(context, 48),
                      minHeight: sw(context, 48),
                    ),
                    icon: Image.asset(
                      'assets/icons/Vector(1).png',
                      width: sw(context, 18),
                      height: sh(context, 20),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
