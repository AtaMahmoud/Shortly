import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorty/src/business_logic/models/short_url.dart';
import 'package:sqflite/sqflite.dart';

import './url_storage_service.dart';

class UrlSqlStorageService implements UrlStorageService {
  static final UrlSqlStorageService db = UrlSqlStorageService._internal();

  UrlSqlStorageService._internal();
  factory UrlSqlStorageService() => db;

  final String tableName = "urls_table";

  Future<Database> initDb() async {
    var docsDirectory = await getApplicationDocumentsDirectory();
    var path = join(docsDirectory.path, "urls.db");
    
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute("""CREATE TABLE $tableName (
         "id" INTEGER PRIMARY KEY
         "code TEXT,"
          "short_link TEXT,"
          "full_short_link TEXT,"
          "short_link2 TEXT,"
          "full_short_link2 TEXT,"
          "short_link3 TEXT,"
          "full_short_link3 TEXT,"
          "share_link TEXT,"
          "full_share_link TEXT,"
          "original_link TEXT"
          ")""");
    });
  }

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  @override
  Future<void> addShortUrl(ShortUrl shortUrl) {
 // TODO: implement deleteShortUrl
    throw UnimplementedError();
  }

  @override
  Future<void> deleteShortUrl(int urlIndex) {
    // TODO: implement deleteShortUrl
    throw UnimplementedError();
  }

  @override
  List<ShortUrl> getAllShortUrls() {
    // TODO: implement getAllShortUrls
    throw UnimplementedError();
  }
}
