class PagedMeta {
  final int currentPage;
  final int perPage;
  final int pageCount;
  final int totalCount;

  const PagedMeta({
    required this.currentPage,
    required this.perPage,
    required this.pageCount,
    required this.totalCount,
  });
}

class PagedResult<T> {
  final List<T> data;
  final PagedMeta meta;

  const PagedResult({required this.data, required this.meta});
}
