import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/input.component.dart';
import 'package:promeal/components/toggle.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/theme.config.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/login.screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();

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
            SizedBox(height: AppSize.height(6)),
            Text("SIGN UP",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Theme.of(context).textTheme.bodyLarge!.color)),
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
                  const SizedBox(height: 25),
                   const AppTextField(hint: "Confirm Password", secured: true),
                  SizedBox(height: AppSize.height(2)),
                  Row(
                    children: [
                      Text(
                        "Enable biometric login",
                        style: appStyle(context,),
                      ),
                      const Spacer(),
                      
                      AppToggle(
                        active: appListener.allowBiometric,
                        onTap: (){
                          context.read<AppProvider>().toggleBioMetic();
                        },
                      )
                    ],
                  ),
                  SizedBox(height: AppSize.height(5)),
                  AppButton(pressed: false, onPress: () {}, title: "SIGN UP", primary: true,),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ", style: appStyle(context)),
                      GestureDetector(
                        onTap: (){
                          AppRoutes.irreversibleNavigate(context, const LoginScreen());
                        },
                        child: Text(
                          "Login",
                          style: appStyle(context,
                              color: Theme.of(context).primaryColor),
                        ),
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


appStyle(BuildContext context, {double size = 16, Color? color}) =>
    TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color);
