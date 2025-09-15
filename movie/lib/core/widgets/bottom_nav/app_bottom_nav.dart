import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    this.homeIconAsset,
    this.watchlistIconAsset,
    this.profileIconAsset,
    this.width = 350,
    this.height = 52,
    this.backgroundColor = const Color(0xFF26253A), // #26253A
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final String? homeIconAsset;
  final String? watchlistIconAsset;
  final String? profileIconAsset;
  final double width;
  final double height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    const radius = 20.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor, // بدون بوردر سفید
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                label: 'Home',
                selected: currentIndex == 0,
                onTap: () => onChanged(0),
                asset: homeIconAsset,
                fallbackIcon: Icons.home_outlined,
              ),
            ),
            Expanded(
              child: _NavItem(
                label: 'Watchlist',
                selected: currentIndex == 1,
                onTap: () => onChanged(1),
                asset: watchlistIconAsset,
                fallbackIcon: Icons.favorite_border,
              ),
            ),
            Expanded(
              child: _NavItem(
                label: 'Profile',
                selected: currentIndex == 2,
                onTap: () => onChanged(2),
                asset: profileIconAsset,
                fallbackIcon: Icons.person_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.asset,
    required this.fallbackIcon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? asset;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? Colors.white : Colors.white70;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            child: asset != null
                ? Image.asset(
                    asset!,
                    height: 20,
                    fit: BoxFit.contain,
                    color: color,
                  )
                : Icon(fallbackIcon, size: 20, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
