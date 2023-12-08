import 'package:flutter/material.dart';
import 'package:promeal/config/color.config.dart';
import 'package:promeal/config/style.config.dart';

class AppDecoration {

 static inputDecoration({required String hintText}) {
    return InputDecoration(hintText: hintText, hintStyle: AppTextStyles.comfortaaStyle(), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), filled: true, fillColor: AppColors.bgColor, contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16));
  }
  
}
