import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/input.component.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:provider/provider.dart';

class MealCalenderScreen extends StatefulWidget {
  const MealCalenderScreen({super.key});

  @override
  State<MealCalenderScreen> createState() => _MealCalenderScreenState();
}

class _MealCalenderScreenState extends State<MealCalenderScreen> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Container(),
          actions: [
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Extrude(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  primary: true,
                  radius: 8,
                  child: const SizedBox(
                    width: appbar + 5,
                    height: appbar,
                    child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Meal Calender".toUpperCase(), style: AppStyle.apply(context, fontWeight: FontWeight.w700, size: 18)),
              ],
            ),
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(4)
            ),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            SizedBox(
              height: AppSize.height(4),
            ),
           
             const SizedBox(height: 10),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay *2),
              child: Extrude(child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Day 1"),
                      ],
                    )
                  ],
                ),
              ),),
            ),
            const SizedBox(height: 45),
            FadeInLeft(
              child: Text(
                "New Password",
                style: AppStyle.apply(context),
              ),
            ),
             const SizedBox(height: 10),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay * 2),
              child: AppTextField(
                hint: "Password",
                secured: true,
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 25),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay * 3),
              child: AppTextField(
                hint: "Confirm Password",
                secured: true,
                controller: confirmPasswordController,
              ),
            ),
            const Spacer(),
            BounceInUp(
              child: AppButton(
                pressed: context.watch<AccountProvider>().isLoading,
                onPress: () {
                  
                   context.read<AccountProvider>().changepassword(context);
                
                },
                title: "UPDATE PASSWORD",
                primary: true,
              ),
            ),
            SizedBox(
              height: AppSize.height(10),
            ),
                  ],
                ),
          )),
    );
  }
}
