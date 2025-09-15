import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/core/widgets/app_scaffold.dart';
import 'package:movie/core/widgets/loaders/rotating_asset_loader.dart';
import 'package:movie/features/search/presentation/controllers/search_provider.dart';
import 'package:movie/features/search/presentation/widgets/search_result_card.dart';
import 'package:movie/features/search/presentation/pages/search_no_result_page.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key, required this.query});
  final String query;

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late final TextEditingController _controller;
  late String _query;
  bool _navigatedNoResult = false;

  @override
  void initState() {
    super.initState();
    _query = widget.query;
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
    setState(() {
      _query = q;
      _navigatedNoResult = false; // برای جست‌وجوی جدید دوباره اجازه ناوبری بده
    });
  }

  void _clear() {
    _controller.clear();
    setState(() {
      _query = '';
      _navigatedNoResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = _query.isEmpty
        ? null
        : ref.watch(searchResultsProvider(_query));

    return AppScaffold(
      padForStatus: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // فلش برگشت بالا (Vector2)
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

            // نوار سرچ همیشه بالای لیست
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
            const SizedBox(height: 12),

            // نتایج
            Expanded(
              child: _query.isEmpty
                  ? const SizedBox()
                  : resultsAsync!.when(
                      loading: () => const Center(
                        child: RotatingAssetLoader(
                          assetPath: 'assets/icons/Group0.png',
                          size: 44,
                        ),
                      ),
                      error: (e, _) => Center(
                        child: Text(
                          'Error: $e',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      data: (paged) {
                        // اگر نتیجه‌ای نبود → صفحه No Result (فقط یکبار ناوبری کن)
                        if (paged.data.isEmpty && !_navigatedNoResult) {
                          _navigatedNoResult = true;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!context.mounted) return;
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) =>
                                    SearchNoResultPage(query: _query),
                              ),
                            );
                          });
                          return const SizedBox.shrink();
                        }

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: paged.data.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final m = paged.data[index];
                            return SearchResultCard(
                              imageUrl: m.poster,
                              title: m.title,
                              year: m.year,
                              rating: m.imdbRating,
                              runtimeMinutes:
                                  null, // بعداً با جزئیات پر می‌کنیم
                              onTap: () {
                                // TODO: ناوبری به صفحه جزئیات
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
