import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/config/theme.config.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/authscreen/component/login.component.dart';
import 'package:promeal/screen/authscreen/component/signup.component.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
            SizedBox(height: AppSize.height(7)),
            appListener.isLogin
                ? LoginSection(appListener: appListener)
                : SignupSection(appListener: appListener),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(5.5)
              ),
              child: AppButton(
                pressed: false,
                onPress: () {},
                title: appListener.isLogin? "LOGIN": "SIGNUP",
                primary: true,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    appListener.isLogin
                        ? "Don't have an account "
                        : "Already have an account ",
                    style: AppStyle.apply(context)),
                GestureDetector(
                  onTap: () {
                    // AppRoutes.irreversibleNavigate(
                    //     context, const SignupScreen());
                    context.read<AppProvider>().toggleAuth();
                  },
                  child: Text(
                    !appListener.isLogin ? "Login" : "Signup",
                    style: AppStyle.apply(context,
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
