import 'package:shorty/src/services/user/user_service.dart';
import 'package:shorty/src/services/user_storage/user_storage_service.dart';

import '../service_locator.dart';

class UserServiceImplementation implements UserService {
  final userStorageService = serviceLocator<UserStorageService>();
  @override
  bool? getOnBoardingFlag() => userStorageService.getFlag();

  @override
  Future<void> setOnBoardingFlag({required bool value}) async {
    await userStorageService.setFlag(value: value);
  }
}
