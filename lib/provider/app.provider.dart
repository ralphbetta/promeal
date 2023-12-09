import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _checked = true;
  bool get checked => _checked;

  checkBox() {
    _checked = !_checked;
    notifyListeners();
  }

  
}
