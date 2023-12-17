
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/checkbox.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/input.component.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({
    super.key,
    required this.appListener,
  });

  final AppProvider appListener;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        FadeInDown(
          delay: const Duration(milliseconds: 0),
          child: Text("LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyLarge!.color)),
        ),
        const SizedBox(height: 10),
        AnimatedTextKit(
          // repeatForever: true,
          pause: const Duration(seconds: 60),
          animatedTexts: [
            TypewriterAnimatedText(
              "Be in control of your food",
              textStyle: AppStyle.apply(context),
              speed: const Duration(milliseconds: 50),
            ),
          ],
          onTap: () {},
        ),
        SizedBox(height: AppSize.height(5)),
        FadeInUp(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(5)),
            child: Column(
              children: [
                 AppTextField(hint: "Email", icon: Icons.email_outlined, controller: emailController),
                const SizedBox(height: 25),
                 AppTextField(hint: "Password", secured: true, controller: passwordController,),
                SizedBox(height: AppSize.height(4)),
                Row(
                  children: [
                    /*-----------------------------
                    Extrude handles ontap actions
                    -----------------------------*/
                    Extrude(
                      onPress: () {
                        context.read<AppProvider>().checkBox();
                      },
                      pressed: true,
                      radius: 3,
                      child: appCheckbox(checked: appListener.checked),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Remember Me",
                      style: AppStyle.apply(context),
                    ),
                    const Spacer(),
                    Text("Forgot Password?",
                        style: AppStyle.apply(context,
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
                SizedBox(height: AppSize.height(8)),
              
               
              ],
            ),
          ),
        ),
      ],
    );
  }
}

