import '../../services/service_locator.dart';
import '../../services/url/short_url_service.dart';
import '../models/failure.dart';
import '../models/short_url.dart';
import '../models/view_state.dart';
import './base_model.dart';

class UrlsViewModel extends BaseModel {
  final List<ShortUrl> _shortUrls = [];
  List<ShortUrl> get shortUrls => _shortUrls.reversed.toList();

  /// History only failure class to avoid un needed rebuilds for [MainScreen]
  Failure? _historyLoadingFailure;
  Failure? get historyLoadingFailure => _historyLoadingFailure;

  /// Failure to all Methods except [getShortUrlsHistory()]
  Failure? _mainFailure;
  Failure? get mainFailure => _mainFailure;

  final _urlsService = serviceLocator<ShortUrlService>();

  void _restFailure() {
    _mainFailure = null;
    _historyLoadingFailure = null;
  }

  /// Short [url] , saveing it to the memory and local DB
  Future<void> shortUrl(String url) async {
    _restFailure();

    try {
      final _shortUrl = await _urlsService.shortUrl(url);
      _shortUrls.add(_shortUrl);
    } on Failure catch (e) {
      _mainFailure = e;
    }
    notifyListeners();
  }

  /// Get user shortened urls from the local database
  Future<void> getShortUrlsHistory() async {
    _restFailure();
    updateState(ViewState.busy);

    try {
      final urlsHistory = await _urlsService.getUrlsHistory();
      _shortUrls.addAll(urlsHistory);
    } on Failure catch (e) {
      _historyLoadingFailure = e;
    }

    updateState(ViewState.idle);
  }

  /// remove [shortenUrl] from memory and the local database
  /// 
  /// Nothing will hapen if [shortenUrl] is not add the DB or memory
  Future<void> removeUrlFromHistory(ShortUrl shortenUrl) async {
    _restFailure();

    try {
      final index = _shortUrls.indexOf(shortenUrl);
      if (index != -1) {
        _shortUrls.removeAt(index);
        notifyListeners();
        await _urlsService.removeShortUrl(index);
      }
    } on Failure catch (e) {
      _mainFailure = e;
      notifyListeners();
    }
  }
}
