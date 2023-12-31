import 'package:flutter/material.dart';

class AppRoutes{

 static Future<dynamic> irreversibleNavigate(BuildContext context, screen) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false);
}

static Future<dynamic> push(BuildContext context, screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  },
   settings: RouteSettings(
      name: screen.toString(),
    ),
  ));
}
}
