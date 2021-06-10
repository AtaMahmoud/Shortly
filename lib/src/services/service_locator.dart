import 'package:get_it/get_it.dart';
import 'package:shorty/src/services/web_api/web_api.dart';
import 'package:shorty/src/services/web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImplementaion());
}
