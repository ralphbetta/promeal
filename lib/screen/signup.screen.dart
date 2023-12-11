import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/config/theme.config.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/authscreen/component/signup.component.dart';
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
            Text("Be in control of your food", style: AppStyle.apply(context)),
            SizedBox(height: AppSize.height(5)),
            SignupSection(appListener: appListener)
          ],
        ),
      )),
    );
  }
}

