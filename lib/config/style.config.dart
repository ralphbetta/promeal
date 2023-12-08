import 'package:flutter/material.dart';

class AppTextStyles {
  
  static TextStyle headerTextStyle(context, {Color color = Colors.red}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: 'San',
      color: color == Colors.red ? Theme.of(context).textTheme.bodyLarge!.color: color,
    );
  }


  static TextStyle mediumHeaderTextStyle(context, {Color color = Colors.teal}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
          color: color == Colors.teal ? Theme.of(context).textTheme.bodyLarge!.color: color,
    );
  }

  static TextStyle montserratStyle(context,{Color color = Colors.teal, double fontSize = 20}) {
    return TextStyle(
      color: color == Colors.teal ? Theme.of(context).textTheme.bodyLarge!.color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
  }

  static TextStyle headingStyles(
      {double fontSize = 36, Color color = Colors.white}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 2,
    );
  }

  static TextStyle normalStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      letterSpacing: 1.7,
      height: 1.5,
    );
  }

  static TextStyle comfortaaStyle() {
    return const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey);
  }
}
