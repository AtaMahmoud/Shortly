import '../service_locator.dart';
import '../user/user_service.dart';
import '../user_storage/user_storage_service.dart';

class UserServiceImplementation implements UserService {
  final userStorageService = serviceLocator<UserStorageService>();
  @override
  bool? getOnBoardingFlag() => userStorageService.getFlag();

  @override
  Future<void> setOnBoardingFlag({required bool value}) async {
    await userStorageService.setFlag(value: value);
  }
}
