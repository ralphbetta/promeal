import 'package:flutter/material.dart';

class AppStyle {
  static apply(BuildContext context, {double size = 16, Color? color, FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).textTheme.bodyLarge!.color);
}
