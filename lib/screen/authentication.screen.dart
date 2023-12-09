import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/input.component.dart';
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
          child: SingleChildScrollView(
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
            SizedBox(height: AppSize.height(7)),
            Text("Login", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Theme.of(context).textTheme.bodyLarge!.color)),
            const SizedBox(height: 10),
            Text("Be in control of your food", style: appStyle(context)),
            SizedBox(height: AppSize.height(5)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(5)),
              child: Column(
                children: [
                  const AppTextField(hint: "Email", icon: Icons.email_outlined),
                  const SizedBox(height: 25),
                  const AppTextField(hint: "Password", secured: true),
                  SizedBox(height: AppSize.height(4)),
                  Row(
                    children: [
                      Extrude(
                        pressed: true,
                        radius: 3,
                        child: appCheckbox(onTap: () {}),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Remember Me",
                        style: appStyle(context),
                      ),
                      const Spacer(),
                      Text("Forgot Password?", style: appStyle(context, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  SizedBox(height: AppSize.height(8)),
                  AppButton(pressed: false, onPress: () {}, title: "Login"),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ", style: appStyle(context)),
                      Text(
                        "Signup",
                        style: appStyle(context, color: Theme.of(context).primaryColor),
                      )
                    ],
                  )
                ],
              ),
            )
                  ],
                ),
          )),
    );
  }
}

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

TextStyle appStyle(BuildContext context, {double size = 16, Color? color}) => TextStyle(fontSize: size, fontWeight: FontWeight.w400, color: color ?? Theme.of(context).textTheme.bodyLarge!.color);
