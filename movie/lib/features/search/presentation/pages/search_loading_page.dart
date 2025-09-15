import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/widgets/loaders/rotating_asset_loader.dart';
import 'package:movie/features/search/presentation/pages/search_results_page.dart';
import 'package:movie/features/search/presentation/controllers/search_history_provider.dart';

class SearchLoadingPage extends ConsumerStatefulWidget {
  const SearchLoadingPage({super.key, required this.initialQuery});
  final String initialQuery;

  @override
  ConsumerState<SearchLoadingPage> createState() => _SearchLoadingPageState();
}

class _SearchLoadingPageState extends ConsumerState<SearchLoadingPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);

    // ذخیره تاریخچه + رفتن به صفحه نتایج بعد از یک لحظه (برای نمایش لودینگ)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchHistoryNotifierProvider.notifier).add(widget.initialQuery);
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SearchResultsPage(query: widget.initialQuery),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            // ردیف فلش برگشت (Vector2) بالای سرچ‌بار
            SizedBox(
              height: 28,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Image.asset(
                      'assets/icons/Vector2.png',
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // سرچ‌بار کپسولی با متن کوئری
            SizedBox(
              height: 50,
              child: TextField(
                controller: _controller,
                readOnly: true, // در صفحه لودینگ فقط نمایش؛ ویرایش در صفحه قبلی
                cursorColor: Colors.white70,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF3A3754),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.search, size: 20, color: Colors.white70),
                  ),
                  suffixIcon: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white24,
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
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // لودینگ چرخشی (Group0) وسط صفحه
            const Expanded(
              child: Center(
                child: RotatingAssetLoader(
                  assetPath: 'assets/icons/Group0.png',
                  size: 44,
                  duration: Duration(milliseconds: 900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
