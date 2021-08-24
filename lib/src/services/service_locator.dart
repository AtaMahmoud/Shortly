import 'package:get_it/get_it.dart';

import '../business_logic/view_models/urls_view_model.dart';
import '../business_logic/view_models/user_view_model.dart';
import '../services/url/short_url_service.dart';
import '../services/url/short_url_service_implementation.dart';
import './url_storage/url_storage_service.dart';
import './url_storage/url_storage_service_implementation.dart';
import './user/user_service.dart';
import './user/user_service_implementation.dart';
import './user_storage/user_storage_service.dart';
import './user_storage/user_storage_service_implementation.dart';
import './web_api/web_api.dart';
import './web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerFactory<WebApi>(() => WebApiImplementaion());
  serviceLocator.registerLazySingleton<UserStorageService>(
      () => UserStorageServiceImplementation());
  serviceLocator
      .registerFactory<UserService>(() => UserServiceImplementation());
  serviceLocator.registerLazySingleton<UrlStorageService>(
      () => UrlStorageServiceImplementation());
  serviceLocator.registerFactory<ShortUrlService>(
      () => ShortUrlServiceImplementation());

  serviceLocator.registerFactory<UserViewModel>(() => UserViewModel());
  serviceLocator.registerLazySingleton<UrlsViewModel>(() => UrlsViewModel());
}