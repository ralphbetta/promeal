import 'package:flutter/material.dart';

class AppStyle {
  static apply(BuildContext context, {double size = 16, Color? color}) =>
      TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w400,
          color: color ?? Theme.of(context).textTheme.bodyLarge!.color);
}
