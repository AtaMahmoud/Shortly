import '../../business_logic/models/short_url.dart';

abstract class UrlStorageService {
  Future<void> addShortUrl(ShortUrl shortUrl);
  Future<void> deleteShortUrl(int urlIndex);
  List<ShortUrl> getAllShortUrls();
}
