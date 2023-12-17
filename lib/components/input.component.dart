
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final bool secured;
  final IconData? icon;

  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.secured = false,
    this.icon,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _visibility = true;
  toggle() {
   setState(() {
      _visibility = !_visibility;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Extrude(
      pressed: true,
      child: Container(
        padding: const EdgeInsets.only(left: 14),
        width: double.infinity,
        height: 52,
        child: TextField(
          obscureText: widget.secured ? _visibility : false,
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.icon != null
                  ? Container(padding: const EdgeInsets.only(right: 1, top: 16, bottom: 10), child: Icon(widget.icon))
                  : widget.secured
                      ? GestureDetector(onTap: toggle, child: Container(padding: const EdgeInsets.only(right: 1, top: 16, bottom: 10), child:  Icon(_visibility? Icons.visibility: Icons.visibility_off)))
                      : Container(),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 19)),
        ),
      ),
    );
  }
}
