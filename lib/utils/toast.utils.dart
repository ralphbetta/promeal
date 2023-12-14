import 'package:flutter/material.dart';

showToast(BuildContext context, message){
  return ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  ),
);
}