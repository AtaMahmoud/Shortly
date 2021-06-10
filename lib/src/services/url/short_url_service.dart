import 'package:shorty/src/business_logic/models/shorten_url.dart';

abstract class ShortUrlService {
  Future<void> removeShortUrl(int shortUrlIndex);
  Future<List<ShortenUrl>> getUrlsHistory();
  Future<ShortenUrl> shortUrl(String url);
}
