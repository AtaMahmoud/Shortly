import 'package:flutter/foundation.dart';

import '../models/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void updateState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
