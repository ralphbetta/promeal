import 'package:flutter/material.dart';

appCheckbox({bool checked = true, Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(2),
      width: 25,
      height: 25,
      child: checked ? const Icon(Icons.check) : Container(),
    ),
  );
}