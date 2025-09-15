import 'package:flutter/material.dart';
import 'package:movie/features/search/presentation/pages/search_loading_page.dart';

class MovieSearchBar extends StatefulWidget {
  const MovieSearchBar({
    super.key,
    this.onSearch, // NEW: کال‌بک اختیاری
    this.hintText = 'Search movies...',
  });

  final ValueChanged<String>? onSearch;
  final String hintText;

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  final _controller = TextEditingController();

  void _submit() {
    final q = _controller.text.trim();
    if (q.isEmpty) return;

    // اگر کال‌بک بیرونی دادی، از همون استفاده کن؛ وگرنه خودم می‌رم صفحه لودینگ
    if (widget.onSearch != null) {
      widget.onSearch!(q);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SearchLoadingPage(initialQuery: q)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _submit(),
        cursorColor: Colors.white70,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF3A3754),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          prefixIcon: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _submit,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.search, size: 20, color: Colors.white70),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 44),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.9),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.white, width: 1.4),
          ),
        ),
      ),
    );
  }
}
