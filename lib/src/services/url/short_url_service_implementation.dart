import 'package:shorty/src/business_logic/models/shorten_url.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/services/url/short_url_service.dart';
import 'package:shorty/src/services/url_storage/storage_service.dart';
import 'package:shorty/src/services/web_api/web_api.dart';

class ShortUrlServiceImplementation implements ShortUrlService {
  final _urlStorageService = serviceLocator<UrlStorageService>();
  final _webApi = serviceLocator<WebApi>();


  @override
  Future<List<ShortenUrl>> getUrlsHistory() async {
    return _urlStorageService.getAllShortenUrls();
  }

  @override
  Future<void> removeShortUrl(int shortUrlIndex) async {
    await _urlStorageService.deleteShortenUrl(shortUrlIndex);
  }

  @override
  Future<ShortenUrl> shortUrl(String url) async {
    final shortenUrl = await _webApi.shortUrl(url);
    await _urlStorageService.addShortenUrl(shortenUrl);
    return shortenUrl;
  }
}
