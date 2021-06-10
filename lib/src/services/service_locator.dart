import 'package:get_it/get_it.dart';
import 'package:shorty/src/services/user/user_service_implementation.dart';
import 'package:shorty/src/services/user_storage/user_storage_service.dart';
import 'package:shorty/src/services/user_storage/user_storage_service_implementation.dart';
import 'package:shorty/src/services/web_api/web_api.dart';
import 'package:shorty/src/services/web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImplementaion());
  serviceLocator.registerLazySingleton<UserStorageService>(
      () => UserStorageServiceImplementation());
}
