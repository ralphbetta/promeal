class APIRoute {
  //admin@gmail.com -- 1234

  static String local = 'http://192.168.0.136:4050';
  static String live = 'https://promeal.bubblemeet.online';

  static String base = live;

  static String login = "$base/api/account/login";
  static String register = "$base/api/account/register";
  static String refresh = "$base/api/account/refresh";
  static String accounts = "$base/api/account/users";
  static String transfers = "$base/api/food/transferhistory";
  static String notifications = "$base/api/notification/read";
  static String transfer = "$base/api/food/transfer";
  static String claim = "$base/api/food/claim";

  static String update = "$base/api/account/profile";
  static String validation = "$base/api/account/validation";
}
