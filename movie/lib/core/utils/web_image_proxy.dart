import 'package:flutter/foundation.dart';

/// روی وب، آدرس تصویر را از طریق پروکسی عبور می‌دهیم تا CORS و mixed-content حل شود.
/// روی موبایل/دسکتاپ همان URL اصلی برگردانده می‌شود.
String webImageUrl(String url) {
  if (!kIsWeb || url.isEmpty) return url;
  Uri u;
  try {
    u = Uri.parse(url);
  } catch (_) {
    return url;
  }
  // images.weserv.nl توصیه‌شده برای پروکسی تصویر
  final hostPath = '${u.host}${u.path}${u.hasQuery ? '?${u.query}' : ''}';
  return 'https://images.weserv.nl/?url=$hostPath';
}
