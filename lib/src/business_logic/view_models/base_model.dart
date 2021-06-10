import 'package:flutter/foundation.dart';

import 'package:shorty/src/business_logic/models/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void updateState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
