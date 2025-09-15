import 'package:flutter/material.dart';

class RotatingAssetLoader extends StatefulWidget {
  const RotatingAssetLoader({
    super.key,
    this.assetPath =
        'assets/icons/Group0.png', // اگر در images است، مسیر را عوض کن
    this.size = 44,
    this.duration = const Duration(milliseconds: 900),
  });

  final String assetPath;
  final double size;
  final Duration duration;

  @override
  State<RotatingAssetLoader> createState() => _RotatingAssetLoaderState();
}

class _RotatingAssetLoaderState extends State<RotatingAssetLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: RotationTransition(
        turns: _ctrl,
        child: Image.asset(
          widget.assetPath,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
