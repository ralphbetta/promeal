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

  checkBox() {
    _checked = !_checked;
    notifyListeners();
  }

  toggleAuth() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  toggleBioMetic(){
    _allowBiometric = !_allowBiometric;
    notifyListeners();
  }

  toggleBottomNav(int index){
    _bottomNavIndex = index;
    notifyListeners();
  }

}
