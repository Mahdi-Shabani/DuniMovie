import 'package:flutter/material.dart';

class CategoryChipsRow extends StatefulWidget {
  const CategoryChipsRow({super.key});

  @override
  State<CategoryChipsRow> createState() => _CategoryChipsRowState();
}

class _CategoryChipsRowState extends State<CategoryChipsRow> {
  final List<String> _items = const [
    'All Categories',
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Sci‑Fi',
  ];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32, // ارتفاع طبق طرح
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            for (int i = 0; i < _items.length; i++) ...[
              _ChipItem(
                label: _items[i],
                selected: _selected == i,
                // برای چیپ اول آیکن Grid نمایش بده:
                leading: i == 0
                    ? const _GridIcon() // اگر آیکن اختصاصی داری جایگزینش کن
                    : null,
                onTap: () => setState(() => _selected = i),
              ),
              if (i != _items.length - 1) const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget? leading;
  final VoidCallback onTap;

  const _ChipItem({
    required this.label,
    required this.selected,
    required this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 32,
          padding: EdgeInsets.symmetric(horizontal: leading != null ? 10 : 12),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withOpacity(0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.9),
              width: selected ? 1.4 : 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 6)],
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// آیکن Grid برای "All Categories"
// اگر آیکن اختصاصی در assets/icons داری، این ویجت را با Image.asset جایگزین کن:
// Image.asset('assets/icons/your_grid_icon.png', width: 16, height: 16)
class _GridIcon extends StatelessWidget {
  const _GridIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.grid_view_rounded,
      size: 16,
      color: Colors.white.withOpacity(0.95),
    );
  }
}
