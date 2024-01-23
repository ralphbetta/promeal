import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/mealcaldender.model.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/utils/dateformat.utils.dart';
import 'package:provider/provider.dart';

class MealStatistics extends StatefulWidget {
  const MealStatistics({super.key});

  @override
  State<MealStatistics> createState() => _MealStatisticsState();
}

class _MealStatisticsState extends State<MealStatistics> {


  @override
  Widget build(BuildContext context) {

    final appListener = context.watch<AppProvider>();
    ScheduleModel calenderScehudle =  context.watch<EventProvider>().mealCalender!;

    bool available(index){
    List<Schedule> currentSchedule = calenderScehudle.schedules!.where((element) => element.date == calenderScehudle.presentCalender![index].date).toList();
    List<Schedule> nextSchedule = calenderScehudle.schedules!.where((element) => element.date == calenderScehudle.nextCalender![index].date).toList();

    if(appListener.nextWeek == 1 && nextSchedule.isEmpty){
      return false;
    }

    if(appListener.nextWeek == 0 && currentSchedule.isEmpty){
      return false;
    }
    return true;
  }

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
                Text("Meal Statistics".toUpperCase(),
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
                height:
                 AppSize.height(2),
              ),
          
          
              ...List.generate(
                  calenderScehudle.nextCalender!.length,
                  (index) => SlideInUp(
                        duration:
                            Duration(milliseconds: animationDelay * index + 1),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Extrude(
                            onPress: () {

                              //todo

                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Day ${index + 1}"),
                                          SizedBox(height: 15),
                                           Text("${formatDateDot(calenderScehudle.presentCalender![index].date!)}", style: TextStyle(color: Theme.of(context).primaryColor),)
                                        ],
                                      ),
                                      ElasticIn(
                                        child: available(index)? Row(
                                          children: [
                                            Extrude(
                                                pressed: true,
                                                radius: 3,
                                                child: Container(
                                                  width: AppSize.width(15),
                                                  height: AppSize.width(15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("43", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                                      SizedBox(height: 5),
                                                      Text("Breakfast", style: TextStyle(fontSize: 10),)
                                                    ],
                                                  ),
                                                )),
                                                SizedBox(width: 5),
                                                Extrude(
                                                pressed: true,
                                                radius: 3,
                                                child: Container(
                                                  width: AppSize.width(15),
                                                  height: AppSize.width(15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("43", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                                      SizedBox(height: 5),
                                                      Text("Lunch", style: TextStyle(fontSize: 10),)
                                                    ],
                                                  ),
                                                )),
                                                 SizedBox(width: 5),
                                                  Extrude(
                                                pressed: true,
                                                radius: 3,
                                                child: Container(
                                                  width: AppSize.width(15),
                                                  height: AppSize.width(15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("0", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                                      SizedBox(height: 5),
                                                      Text("Dinner", style: TextStyle(fontSize: 10),)
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ): 
                                            Extrude(
                                            pressed: true,
                                            radius: 3,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 6
                                              ),
                                              child: Text("No Actions", style: TextStyle(color: Theme.of(context).hintColor),),
                                            )),
                                      )
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
                ),
          )),
    );
  }
}
