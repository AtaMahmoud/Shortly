import '../../business_logic/models/failure.dart';
import '../../business_logic/models/short_url.dart';
import '../../services/service_locator.dart';
import '../url_storage/url_storage_service.dart';
import '../web_api/web_api.dart';
import './short_url_service.dart';

class ShortUrlServiceImplementation implements ShortUrlService {
  final _urlStorageService = serviceLocator<UrlStorageService>();
  final _webApi = serviceLocator<WebApi>();

  @override
  Future<List<ShortUrl>> getUrlsHistory() async {
    try {
      return _urlStorageService.getAllShortUrls();
    } on Failure catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> removeShortUrl(int shortUrlIndex) async {
    try {
      await _urlStorageService.deleteShortUrl(shortUrlIndex);
    } on Failure catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<ShortUrl> shortUrl(String url) async {
    try {
      final shortUrl = await _webApi.shortUrl(url);
      await _urlStorageService.addShortUrl(shortUrl);
      return shortUrl;
    } on Failure catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }
}
