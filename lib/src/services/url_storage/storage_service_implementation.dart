import 'package:hive/hive.dart';
import 'package:shorty/src/business_logic/models/shorten_url.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shorty/src/services/url_storage/storage_service.dart';
import 'package:shorty/src/util/constants.dart';

class StorageServiceImplementation extends UrlStorageService {
  @override
  Future<void> addShortenUrl(ShortenUrl shortenUrl) async {
    final box = Hive.box<ShortenUrl>(urlsBoxName);
    await box.add(shortenUrl);
  }

  @override
  Future<void> deleteShortenUrl(int urlIndex) async {
    final box = Hive.box<ShortenUrl>(urlsBoxName);
    await box.deleteAt(urlIndex);
  }

  @override
  List<ShortenUrl> getAllShortenUrls() {
    final box = Hive.box<ShortenUrl>(urlsBoxName);
    return box.values.toList();
  }
}
