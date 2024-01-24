import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/color.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/history.model.dart';
import 'package:promeal/model/intrest.model.dart';
import 'package:promeal/model/mealcaldender.model.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/screen/statdetails.screen.dart';
import 'package:promeal/utils/dateformat.utils.dart';
import 'package:provider/provider.dart';

class MealHistory extends StatefulWidget {
  const MealHistory({super.key});

  @override
  State<MealHistory> createState() => _MealHistoryState();
}

class _MealHistoryState extends State<MealHistory> {
  @override
  Widget build(BuildContext context) {
    List<HistoryModel> history = context.watch<EventProvider>().history;

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
                Text("Meal History".toUpperCase(),
                    style: AppStyle.apply(context,
                        fontWeight: FontWeight.w700, size: 18)),
              ],
            ),
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.height(2),
              ),
              ...List.generate(history.length, (index) {
                List<IntrestModel> event =
                    context.watch<EventProvider>().weeklyIntrest;

                String count(DateTime date, {String mclass = "Breakfast"}) {
                  List<IntrestModel> data = event
                      .where((element) =>
                          element.mclass == mclass &&
                          element.date!.isAtSameMomentAs(date))
                      .toList();

                  return data.length.toString();
                }

                return SlideInUp(
                  duration: Duration(milliseconds: animationDelay * index + 1),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Extrude(
                      onPress: () {
                        //todo

                        // AppRoutes.push(context, MealStatisticsDetails(date: calenderScehudle.presentCalender![index].date!));
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date: ${formatDateDot(history[index].date!)}",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                Extrude(
                                    pressed: true,
                                    radius: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: Text(
                                        "${history[index].reviews!.length} Review",
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor),
                                      ),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Extrude(
                                    pressed: true,
                                    radius: 3,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          "B",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )),
                                    )),
                                SizedBox(width: 10),
                                Text("${history[index].breakfast}")
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Extrude(
                                    pressed: true,
                                    radius: 3,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          "L",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )),
                                    )),
                                SizedBox(width: 10),
                                Text("${history[index].breakfast}")
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Extrude(
                                    pressed: true,
                                    radius: 3,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          "D",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )),
                                    )),
                                SizedBox(width: 10),
                                Text("${history[index].breakfast}"),
                                Expanded(child: Container()),
                                Extrude(
                                  pressed: true,
                                  radius: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5
                                    ),
                                    child: SizedBox(
                                      width: 33,
                                      height: 33,
                                      child: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.primary,)),
                                  ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: AppSize.height(10),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
