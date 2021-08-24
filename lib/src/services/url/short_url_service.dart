import '../../business_logic/models/short_url.dart';

abstract class ShortUrlService {
  Future<void> removeShortUrl(int shortUrlIndex);
  Future<List<ShortUrl>> getUrlsHistory();
  Future<ShortUrl> shortUrl(String url);
}
