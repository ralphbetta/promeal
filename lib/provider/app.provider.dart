import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _checked = true;
  bool get checked => _checked;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _allowBiometric = true;
  bool get allowBiometric => _allowBiometric;

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  int _historyTabIndex = 0;
  int get historyTabIndex => _historyTabIndex;

  checkBox() {
    _checked = !_checked;
    notifyListeners();
  }

  toggleAuth() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  toggleBioMetic() {
    _allowBiometric = !_allowBiometric;
    notifyListeners();
  }

  toggleBottomNav(int index) {
    if (_bottomNavIndex == 4 && index == 4) {
      _bottomNavIndex = 0;
    } else {
      _bottomNavIndex = index;
    }

    notifyListeners();
  }

  toggleHistoryTab(int index) {
    _historyTabIndex = index;
    notifyListeners();
  }
}
