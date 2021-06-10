import 'package:shorty/src/business_logic/models/shorten_url.dart';
import 'package:shorty/src/business_logic/models/view_state.dart';
import 'package:shorty/src/business_logic/view_models/base_model.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/services/url/short_url_service.dart';

class UrlsViewModel extends BaseModel {
  final List<ShortenUrl> _shortenUrls = [];
  List<ShortenUrl> get shortenUrls => _shortenUrls.reversed.toList();

  final _urlsService = serviceLocator<ShortUrlService>();

  Future<void> shortUrl(String url) async {
    updateState(ViewState.busy);

    final _shortenUrl = await _urlsService.shortUrl(url);
    _shortenUrls.add(_shortenUrl);

    updateState(ViewState.idle);
  }

  Future<void> getShortUrlsHistory() async {
    updateState(ViewState.busy);

    final urlsHistory = await _urlsService.getUrlsHistory();
    _shortenUrls.addAll(urlsHistory);

    updateState(ViewState.idle);
  }

  Future<void> removeUrlFromHistory(int index) async {
    updateState(ViewState.busy);

    _shortenUrls.removeAt(index);
    await _urlsService.removeShortUrl(index);

    updateState(ViewState.idle);
  }
}
