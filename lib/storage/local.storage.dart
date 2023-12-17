import 'package:shared_preferences/shared_preferences.dart';

class AppStorage{

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

    Future<dynamic> clearToken() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     var value = await prefs.remove('token');
     return value;
   }


}