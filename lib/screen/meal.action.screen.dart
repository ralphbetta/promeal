import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/screen/scan.screen.dart';

class MealActionScreen extends StatefulWidget {
  const MealActionScreen({super.key});

  @override
  State<MealActionScreen> createState() => _MealActionScreenState();
}

class _MealActionScreenState extends State<MealActionScreen> {

  final int delay = 400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Container(),
          actions: [
            SizedBox(width: AppSize.width(4)),
            Row(
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
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: AppSize.height(3),
          ),
          SlideInUp(
            duration: Duration(milliseconds: delay ),
            child:  mealActionCard(context, (){}),
          ),
            SlideInUp(
            duration: Duration(milliseconds: delay * 2),
            child:   mealActionCard(context, (){}, title: "Transfer Breakfast", icon: Icons.share),
          ),
            SlideInUp(
            duration: Duration(milliseconds: delay *3),
            child:  mealActionCard(context, (){}, title: "Forffeit Breakfast", icon: Icons.cancel_outlined),
          ),
            SlideInUp(
            duration: Duration(milliseconds: delay *4),
            child:  mealActionCard(context, (){}),
          ),
         
          
          
          SizedBox(
            height: AppSize.height(3),
          ),
        ],
      )),
    );
  }


}



   mealActionCard(BuildContext context, Function()? onTap, { String title = "Claim Breakfask", IconData icon =  Icons.food_bank_outlined}) {
    return Padding(
          padding: EdgeInsets.only(
            left: AppSize.width(4),
            right: AppSize.width(4),
            bottom: 15
          ),
          child: Extrude(
              onPress: () {
                AppRoutes.push(context, const ScanScreen());
              },
              radius: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(4), vertical: 10),
                child: Row(
                  children:  [
                    Text(title),
                    const Spacer(),
                    Extrude(
                      primary: true,
                      child: SizedBox(width: appbar, height: appbar, child: Icon(icon, color: Colors.white,)),
                    )
                  ],
                ),
              )),
        );
  }
