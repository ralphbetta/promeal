import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _checked = true;
  bool get checked => _checked;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  checkBox() {
    _checked = !_checked;
    notifyListeners();
  }

  toggleAuth() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
