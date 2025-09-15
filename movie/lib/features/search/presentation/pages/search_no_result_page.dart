import 'package:flutter/material.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/features/search/presentation/pages/search_results_page.dart';

class SearchNoResultPage extends StatefulWidget {
  const SearchNoResultPage({super.key, required this.query});
  final String query;

  @override
  State<SearchNoResultPage> createState() => _SearchNoResultPageState();
}

class _SearchNoResultPageState extends State<SearchNoResultPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => SearchResultsPage(query: q)),
    );
  }

  void _clear() {
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padForStatus: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // فلش برگشت
            SizedBox(
              height: 28,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Image.asset(
                      'assets/icons/Vector2.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // سرچ‌بار کپسولی
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _submit(),
                cursorColor: Colors.white70,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF3A3754),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  prefixIcon: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  suffixIcon: (_controller.text.isNotEmpty)
                      ? IconButton(
                          onPressed: _clear,
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white70,
                          ),
                        )
                      : null,
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
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // تصویر و متن
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // تصویر Group4
                    // اگر در icons است، مسیر را به assets/icons/Group4.png تغییر بده
                    Image(
                      image: AssetImage('assets/images/Group4.png'),
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Not Found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'We are sorry we cannot find the movie.\nWe are constantly updating the app to contain all what you want.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
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
