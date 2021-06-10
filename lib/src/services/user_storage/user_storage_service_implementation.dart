import 'package:hive/hive.dart';
import 'package:shorty/src/services/user_storage/user_storage_service.dart';
import 'package:shorty/src/util/constants.dart';

class UserStorageServiceImplementation implements UserStorageService {
  final String _key = "shouldDisplayOnBoardingScreen";
  @override
  bool? getFlag() {
    final box = Hive.box<bool>(userSettingsBoxName);

    if (!box.containsKey(_key)) return true;

    return box.get(_key);
  }

  @override
  Future<void> setFlag({required bool value}) async {
    final box = Hive.box(userSettingsBoxName);
    await box.put(_key, value);
  }
}
