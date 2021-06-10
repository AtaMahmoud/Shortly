import 'package:shorty/src/business_logic/models/shorten_url.dart';

abstract class WebApi {
  Future<ShortenUrl> shortUrl(String url);
}
