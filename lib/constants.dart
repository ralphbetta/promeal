import 'package:flutter/material.dart';
import 'package:promeal/config/assets.config.dart';

const double appbar = 37;
const double bottomNav = 53;
const List<IconData> bottom = [
  Icons.home_outlined,
  Icons.search_outlined,
  Icons.qr_code,
  Icons.notifications_outlined,
  Icons.settings_outlined,
];

const List<IconData> bottomFill = [
  Icons.home,
  Icons.search,
  Icons.qr_code,
  Icons.notifications,
  Icons.settings,
];

List<String> bottomPic = [
  AppAsset.homeout,
  AppAsset.transferout,
  AppAsset.dark,
  AppAsset.notificationout,
  AppAsset.settingsout,
];

List<String> bottomFillPic = [
  AppAsset.home,
  AppAsset.transfer,
  AppAsset.dark,
  AppAsset.notification,
  AppAsset.settings,
];

bool bottomIsNew = true;

const List<String> historyTab = ['Transferred Meals', 'Forfeited Meals'];

const List<String> scanTab = ['Share Meals', 'Claim Meals'];
