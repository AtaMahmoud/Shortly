import '../../services/service_locator.dart';
import '../../services/user/user_service.dart';
import '../models/view_state.dart';
import './base_model.dart';

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
