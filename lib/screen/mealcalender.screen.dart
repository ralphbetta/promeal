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
          ...List.generate(5, (index) =>   
          
          SlideInUp(
              duration: Duration(milliseconds: animationDelay * index+1),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 20
                ),
                child: Extrude(child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Day ${index+1}"),

                          Extrude(
                            pressed: true,
                            radius: 3,
                            child: Icon(Icons.check, color: Theme.of(context).primaryColor,))
                        ],
                      )
                    ],
                  ),
                ),),
              ),
            )),
            
           
           
            SizedBox(
              height: AppSize.height(10),
            ),
                  ],
                ),
          )),
    );
  }
}
