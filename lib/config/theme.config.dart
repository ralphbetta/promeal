import 'package:flutter/material.dart';
import 'package:promeal/provider/theme.provider.dart';
import 'package:promeal/storage/local.storage.dart';

class AppTheme {
  void init({bool light = true}) {
    ThemeClass.themeNotifier.value = light ? ThemeMode.light : ThemeMode.dark;
  }

  void switchTheme() async {
    bool status = ThemeClass.themeNotifier.value == ThemeMode.dark ? true : false;
    ThemeClass.themeNotifier.value = status ? ThemeMode.light : ThemeMode.dark;
    AppStorage().updateTheme(status);
  }
}
