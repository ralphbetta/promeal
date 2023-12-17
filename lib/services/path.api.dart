class APIRoute {
  //admin@gmail.com -- 1234

  static String local = 'http://192.168.0.167:4050/api';
  static String live = 'https://9e33-102-215-57-48.ngrok-free.app/api';

  static String base = local;


  static String login = "$base/account/login";
  static String register = "$base/account/register";
  static String refresh = "$base/account/refresh";
  static String update = "$base/account/profile";
  static String validation = "$base/account/validation";

}
