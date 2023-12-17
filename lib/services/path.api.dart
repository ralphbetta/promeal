class APIRoute {
  //admin@gmail.com -- 1234

  static String local = 'http://192.168.0.167:4050';
  static String live = 'https://9e33-102-215-57-48.ngrok-free.app';

  static String base = local;

  static String login = "$base/api/account/login";
  static String register = "$base/api/account/register";
  static String refresh = "$base/api/account/refresh";
  static String accounts = "$base/api/account/users";
  static String transfers = "$base/api/food/transferhistory";
  static String notifications = "$base/api/notification/read";
  static String transfer = "$base/api/food/transfer";

  static String update = "$base/api/account/profile";
  static String validation = "$base/api/account/validation";
}
