import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _checked = true;
  bool get checked => _checked;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _allowBiometric = true;
  bool get allowBiometric => _allowBiometric;

  bool _allowNotification = false;
  bool get allowNotification => _allowNotification;

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  int _historyTabIndex = 0;
  int get historyTabIndex => _historyTabIndex;

  bool _admin = false;
  bool get admin => _admin;

  int _adminDashboardTabIndex = 0;
  int get adminDashboardTabIndex => _adminDashboardTabIndex;

  bool _transferIsOpen = false;
  bool get transferIsOpen => _transferIsOpen;

  int? _transferIndex;
  int? get transferIndex => _transferIndex;

  toggleAdminDashboardTabIndex(int index){
    _adminDashboardTabIndex = index;
    notifyListeners();
  }

  toggleNotification() {
    _allowNotification = !_allowNotification;
    notifyListeners();
  }

  toggleTransferOption() {
    if (_transferIsOpen == true) {
      _transferIndex = null;
    }
    _transferIsOpen = !_transferIsOpen;
    notifyListeners();
  }

  selectTransferOption(int index) {
    _transferIndex = index;
    notifyListeners();
  }

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

  toggleScanTab() {
    _admin = !_admin;
    notifyListeners();
  }
}
