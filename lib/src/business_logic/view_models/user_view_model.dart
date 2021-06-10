import 'package:shorty/src/business_logic/models/view_state.dart';
import 'package:shorty/src/business_logic/view_models/base_model.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/services/user/user_service.dart';
import 'package:shorty/src/services/user/user_service_implementation.dart';

class UserViewModel extends BaseModel {
  final _userService = serviceLocator<UserService>();
  bool _shouldDisplayOnBoardingScreens = true;
  bool get shouldDisplayOnBoardingScreens => _shouldDisplayOnBoardingScreens;

  void getDisplayOnBoardingFlag() {
    _shouldDisplayOnBoardingScreens = _userService.getOnBoardingFlag() as bool;
    updateState(ViewState.idle);
  }

  void setDisplayOnBoardingFlag({required bool value}) async {
    await _userService.setOnBoardingFlag(value: value);
    _shouldDisplayOnBoardingScreens = false;
    updateState(ViewState.idle);
  }
}
