import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shorty/src/business_logic/models/failure.dart';
import 'package:shorty/src/business_logic/models/short_url.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/services/url/short_url_service.dart';
import 'package:shorty/src/services/url/short_url_service_implementation.dart';
import 'package:shorty/src/services/url_storage/url_storage_service.dart';
import 'package:shorty/src/services/web_api/web_api.dart';

class MockWepAi extends Mock implements WebApi {}

class MockUrlsStorageService extends Mock implements UrlStorageService {}

void main() {
  setUpAll(() {
    setupServiceLocator();
    serviceLocator.allowReassignment = true;
  });
  test("Constructing Service should find correct dependencies", () {
    var shortUrlService = serviceLocator<ShortUrlService>();
    expect(shortUrlService, isNotNull);
  });

  group("getAllShortUrls", () {
    final mockUrlStorageService = MockUrlsStorageService();
    final fakeShortUrl = ShortUrl(
        code: "code",
        shortLink: "shortLink",
        fullShortLink: "fullShortLink",
        shortLink2: "shortLink2",
        fullShortLink2: "fullShortLink2",
        shareLink: "shareLink",
        fullShareLink: "fullShareLink",
        originalLink: "originalLink");
    test("Should return list with ShortUrl when storage service returns values",
        () async {
      when(mockUrlStorageService.getAllShortUrls)
          .thenAnswer((_) => [fakeShortUrl, fakeShortUrl, fakeShortUrl]);

      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();
      final shorturls = await urlService.getUrlsHistory();

      expect(shorturls, isList);
      expect(shorturls, isNotEmpty);
    });
    test("Should return empty list when storage service returns empty list",
        () async {
      when(mockUrlStorageService.getAllShortUrls).thenAnswer((_) => []);

      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();
      final shorturls = await urlService.getUrlsHistory();

      expect(shorturls, isList);
      expect(shorturls, isEmpty);
    });
    test(
        "Should throw exception when something went wrong with storage service",
        () async {
      when(mockUrlStorageService.getAllShortUrls)
          .thenThrow(Exception("unable to load data"));

      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();

      expect(() async => await urlService.getUrlsHistory(),
          throwsA(TypeMatcher<Failure>()));
    });
  });

  group("removeShortUrl", () {
    final mockUrlStorageService = MockUrlsStorageService();
    test(
        "Should throw exception when something went wrong with storage service",
        () {
      when(mockUrlStorageService.getAllShortUrls)
          .thenThrow(Exception("unable to load data"));

      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();

      expect(() async => await urlService.getUrlsHistory(),
          throwsA(TypeMatcher<Failure>()));
    });
    test("Should return normally when storage service removes short url", () {
      when(() => mockUrlStorageService.deleteShortUrl(1))
          .thenAnswer((invocation) => (Future<void>.delayed(Duration.zero)));

      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();

      expect(() async => await urlService.removeShortUrl(1), returnsNormally);
    });
  });

  group("shortUrl", () {
    final fakeUrl = "example.or/link.html";
    final mockUrlStorageService = MockUrlsStorageService();
    final mockApi = MockWepAi();
    final fakeShortUrl = ShortUrl(
        code: "code",
        shortLink: "shortLink",
        fullShortLink: "fullShortLink",
        shortLink2: "shortLink2",
        fullShortLink2: "fullShortLink2",
        shareLink: "shareLink",
        fullShareLink: "fullShareLink",
        originalLink: "originalLink");

    test("Should return shorturl object if api manage to shorten the url",
        () async {
      when(() => mockApi.shortUrl(fakeUrl))
          .thenAnswer((invocation) => Future.value(fakeShortUrl));
      when(() => mockUrlStorageService.addShortUrl(fakeShortUrl))
          .thenAnswer((_) => Future.delayed(Duration.zero));

      serviceLocator.registerLazySingleton<WebApi>(() => mockApi);
      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();
      final shorturl = await urlService.shortUrl(fakeUrl);

      expect(shorturl, isNotNull);
    });

    test(
        "Should throw exception when something went wrong with storage service",
        () async {
      when(() => mockApi.shortUrl(fakeUrl))
          .thenAnswer((_) => Future.value(fakeShortUrl));
      when(() => mockUrlStorageService.addShortUrl(fakeShortUrl))
          .thenThrow(Exception("can't save the data"));

      serviceLocator.registerLazySingleton<WebApi>(() => mockApi);
      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();

      expect(() async => await urlService.shortUrl(fakeUrl),
          throwsA(TypeMatcher<Failure>()));
    });

    test("Should throw exception when something went wrong with WebApi service",
        () async {
      when(() => mockApi.shortUrl(fakeUrl))
          .thenThrow(Exception("internal server error"));
      when(() => mockUrlStorageService.addShortUrl(fakeShortUrl))
          .thenAnswer((_) => Future.delayed(Duration.zero));

      serviceLocator.registerLazySingleton<WebApi>(() => mockApi);
      serviceLocator.registerLazySingleton<UrlStorageService>(
          () => mockUrlStorageService);

      final urlService = ShortUrlServiceImplementation();

      expect(() async => await urlService.shortUrl(fakeUrl),
          throwsA(TypeMatcher<Failure>()));
    });
  });
}
