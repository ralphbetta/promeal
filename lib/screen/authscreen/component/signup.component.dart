import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/input.component.dart';
import 'package:promeal/components/toggle.component.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';

class SignupSection extends StatelessWidget {
  const SignupSection({
    super.key,
    required this.appListener,
  });

  final AppProvider appListener;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.width(5)),
      child: Column(
        children: [
          
          FadeInDown(
            delay: const Duration(milliseconds: 0),
            child: Text("SIGNUP",
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
          SizedBox(height: AppSize.height(4)),
          FadeInUp(
            child: Column(
              children: [
                 AppTextField(hint: "Email", icon: Icons.email_outlined, controller: emailController,),
                const SizedBox(height: 20),
                 AppTextField(hint: "Password", secured: true, controller: passwordController),
                const SizedBox(height: 20),
                 AppTextField(hint: "Confirm Password", secured: true, controller: confirmPasswordController),
                SizedBox(height: AppSize.height(2)),
                Row(
                  children: [
                    Text(
                      "Enable biometric login",
                      style: AppStyle.apply(
                        context,
                      ),
                    ),
                    const Spacer(),
                    AppToggle(
                      active: appListener.allowBiometric,
                      onTap: () {
                        context.read<AppProvider>().toggleBioMetic();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.height(5)),
         
        ],
      ),
    );
  }
}
