import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/input.component.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:provider/provider.dart';

class MealFormScreen extends StatefulWidget {
  final int day;
  const MealFormScreen({super.key, this.day = 1});

  @override
  State<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  
  @override
  Widget build(BuildContext context) {

    print(widget.day);

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
                Text("Meals".toUpperCase(), style: AppStyle.apply(context, fontWeight: FontWeight.w700, size: 18)),
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
        
      
            FadeInLeft(
              child: Text(
                "Breakfast",
                style: AppStyle.apply(context),
              ),
            ),
             const SizedBox(height: 10),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay * 2),
              child: AppTextField(
                hint: "Type here....",
                secured: false,
                controller: breakfastController,
                   icon: Icons.fastfood_sharp,
              ),
            ),
            const SizedBox(height: 25),
             FadeInLeft(
              child: Text(
                "Lunch",
                style: AppStyle.apply(context),
              ),
            ),
             const SizedBox(height: 10),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay * 3),
              child: AppTextField(
                hint: "Type here...",
                secured: false,
                controller: luchController,
                   icon: Icons.fastfood_sharp,
              ),
            ),

                const SizedBox(height: 25),
             FadeInLeft(
              child: Text(
                "Dinner",
                style: AppStyle.apply(context),
              ),
            ),
             const SizedBox(height: 10),
            SlideInUp(
              duration: Duration(milliseconds: animationDelay * 4),
              child: AppTextField(
                hint: "Type here...",
                secured: false,
                controller: dinnerController,
                icon: Icons.fastfood_sharp,
              ),
            ),
            const Spacer(),
            BounceInUp(
              child: AppButton(
                
                pressed: context.watch<EventProvider>().processingTransfer,
                onPress: () {
                  
                   context.read<EventProvider>().adminPostFood(context, day: widget.day);
                
                },
                title: "UPDATE",
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
