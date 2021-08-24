import 'package:hive/hive.dart';

import '../../business_logic/models/short_url.dart';
import '../../utils/constants.dart';
import 'url_storage_service.dart';


class UrlStorageServiceImplementation extends UrlStorageService {
  @override
  Future<void> addShortUrl(ShortUrl shortUrl) async {
    final box = Hive.box<ShortUrl>(urlsBoxName);
    await box.add(shortUrl);
  }

  @override
  Future<void> deleteShortUrl(int urlIndex) async {
    final box = Hive.box<ShortUrl>(urlsBoxName);
    await box.deleteAt(urlIndex);
  }

  @override
  List<ShortUrl> getAllShortUrls() {
    final box = Hive.box<ShortUrl>(urlsBoxName);
    return box.values.toList();
  }
}
