import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/mealform.screen.dart';
import 'package:provider/provider.dart';

class MealCalenderScreen extends StatefulWidget {
  const MealCalenderScreen({super.key});

  @override
  State<MealCalenderScreen> createState() => _MealCalenderScreenState();
}

class _MealCalenderScreenState extends State<MealCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();
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
                    child:
                        Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Meal Calender".toUpperCase(),
                    style: AppStyle.apply(context,
                        fontWeight: FontWeight.w700, size: 18)),
              ],
            ),
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.height(2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.width(4)),
              child: Extrude(
                pressed: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.1, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          adminCalenderTab.length,
                          (index) => appListener.nextWeek == index
                              ? ElasticIn(
                                  child: Extrude(
                                    onPress: () {},
                                    pressed: true,
                                    radius: 8,
                                    child: SizedBox(
                                      width: AppSize.width(42),
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                        adminCalenderTab[index],
                                        style:
                                            AppStyle.apply(context, size: 14),
                                      )),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AppProvider>()
                                        .toggleMealCalender(index);
                                  },
                                  child: Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: AppSize.width(42),
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                      adminCalenderTab[index],
                                      style: AppStyle.apply(context, size: 14),
                                    )),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            ...List.generate(
                5,
                (index) => SlideInUp(
                      duration:
                          Duration(milliseconds: animationDelay * index + 1),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Extrude(
                          onPress: () {
                            AppRoutes.push(
                                context,
                                MealFormScreen(
                                    day: appListener.nextWeek == 0
                                        ? index + 1
                                        : -index - 1));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Day ${index + 1}"),
                                    Extrude(
                                        pressed: true,
                                        radius: 3,
                                        child: Icon(
                                          Icons.check,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
