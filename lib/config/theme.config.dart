import 'package:flutter/material.dart';
import 'package:promeal/provider/theme.provider.dart';

class AppTheme {
  void switchTheme() {
    print("hi");
    ThemeClass.themeNotifier.value =
        ThemeClass.themeNotifier.value == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
  }
}