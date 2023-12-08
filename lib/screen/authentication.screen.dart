import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/theme.config.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Extrude(
            radius: 100,
            child: SizedBox(
              width: AppSize.width(42),
              height: AppSize.width(42),
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Extrude(
                    pressed: true,
                    onPress: () {
                      AppTheme().switchTheme();
                    },
                    radius: 100,
                    child: SizedBox(
                      // color: Colors.amber,
                      width: AppSize.width(28),
                      height: AppSize.width(28),
                      child: Container(
                          padding: EdgeInsets.all(AppSize.width(7)),
                          width: 3,
                          child: Image(
                            image: AssetImage(AppAsset.profile),
                            width: 1,
                          )),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSize.height(5)),
          Text("Login", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Theme.of(context).textTheme.bodyLarge!.color)),
          const SizedBox(height: 10),
          Text("Be in control of your food", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).textTheme.bodyLarge!.color)),
          SizedBox(height: AppSize.height(5)),
          const AppTextField(hint: "Email", icon: Icons.email_outlined),
          const SizedBox(height: 15),
          const AppTextField(hint: "Password", secured: true),
        ],
      )),
    );
  }
}

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
  bool _visibility = false;
  toggle() {
    _visibility = !_visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.width(5)),
      child: Column(
        children: [
          Extrude(
            pressed: true,
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              width: double.infinity,
              height: 52,
              child: TextField(
                obscureText: widget.secured ? _visibility : false,
                decoration: InputDecoration(
                    hintText: widget.hint,
                    suffixIcon: widget.icon != null
                        ? Container(padding: const EdgeInsets.only(right: 1, top: 16, bottom: 10), child: Icon(widget.icon))
                        : widget.secured
                            ? GestureDetector(onTap: () {}, child: Container(padding: const EdgeInsets.only(right: 1, top: 16, bottom: 10), child: const Icon(Icons.visibility)))
                            : Container(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 19)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
