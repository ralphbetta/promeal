import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<String> readToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loggedUser = prefs.getString('token') ?? "null";
    return loggedUser;
  }

  Future<dynamic> updateToken(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await prefs.setString('token', data);
    return value;
  }

  Future<bool> readTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedUser = prefs.getBool('theme') ?? true;
    return loggedUser;
  }

  Future<bool> updateTheme(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await prefs.setBool('theme', data);
    return value;
  }

  Future<bool> readNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedUser = prefs.getBool('notification') ?? true;
    return loggedUser;
  }

  Future<bool> updateNotification(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await prefs.setBool('notification', data);
    return value;
  }

  Future<dynamic> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await prefs.remove('token');
    return value;
  }

  Future<String> read({String dataKey = ""}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loggedUser = prefs.getString('token') ?? "null";
    return loggedUser;
  }

  Future<dynamic> set({String dataKey = "", required String data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await prefs.setString('token', data);
    return value;
  }
}
