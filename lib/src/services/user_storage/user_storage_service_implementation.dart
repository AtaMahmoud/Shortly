import 'package:hive/hive.dart';

import '../../utils/constants.dart';
import './user_storage_service.dart';

class UserStorageServiceImplementation implements UserStorageService {
  final String _key = "shouldDisplayOnBoardingScreen";

  /// Get the [shouldDisplayOnBoardingScreen] value from [userSettingsBoxName]
  /// 
  /// return [true] if data box is empty or don't contain[_key]
  @override
  bool? getFlag() {
    final box = Hive.box(userSettingsBoxName);

    if (!box.containsKey(_key)) return true;

    return box.get(_key);
  }

  /// Set [shouldDisplayOnBoardingScreen] value
  @override
  Future<void> setFlag({required bool value}) async {
    final box = Hive.box(userSettingsBoxName);
    await box.put(_key, value);
  }
}
