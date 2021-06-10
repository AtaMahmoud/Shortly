import 'package:shorty/src/business_logic/models/shorten_url.dart';

abstract class UrlStorageService {
  Future<void> addShortenUrl(ShortenUrl shortenUrl);
  Future<void> deleteShortenUrl(int urlIndex);
  List<ShortenUrl> getAllShortenUrls();
  
}
