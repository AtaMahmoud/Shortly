import '../../business_logic/models/short_url.dart';

abstract class WebApi {
  Future<ShortUrl> shortUrl(String url);
}
