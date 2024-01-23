import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/color.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/intrest.model.dart';
import 'package:promeal/model/mealcaldender.model.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/utils/dateformat.utils.dart';
import 'package:promeal/utils/toast.utils.dart';
import 'package:provider/provider.dart';

class StaffMealCalenderScreen extends StatefulWidget {
  const StaffMealCalenderScreen({super.key});

  @override
  State<StaffMealCalenderScreen> createState() =>
      _StaffMealCalenderScreenState();
}

class _StaffMealCalenderScreenState extends State<StaffMealCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();
    final eventListener = context.watch<EventProvider>();

    ScheduleModel calenderScehudle = eventListener.mealCalender!;

    bool available(index) {
      List<Schedule> currentSchedule = calenderScehudle.schedules!
          .where((element) =>
              element.date == calenderScehudle.presentCalender![index].date)
          .toList();
      List<Schedule> nextSchedule = calenderScehudle.schedules!
          .where((element) =>
              element.date == calenderScehudle.nextCalender![index].date)
          .toList();

      if (appListener.nextWeek == 1 && nextSchedule.isEmpty) {
        return false;
      }

      if (appListener.nextWeek == 0 && currentSchedule.isEmpty) {
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
                    context.read<EventProvider>().completeEdit();
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
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.height(2),
              ),

              // TAB SECTION

              ...List.generate(
                  calenderScehudle.nextCalender!.length,
                  (index){

                    return    
                   Column(
                        children: [
                          SlideInUp(
                            duration: Duration(
                                milliseconds: animationDelay * index + 1),
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 5),
                              child: Extrude(
                                onPress: () {

                             
                                  List<Schedule> currentSchedule =
                                      calenderScehudle.schedules!
                                          .where((element) =>
                                              element.date ==
                                              calenderScehudle
                                                  .presentCalender![index].date)
                                          .toList();

                                  // List<Schedule> nextSchedule = calenderScehudle
                                  //     .schedules!
                                  //     .where((element) =>
                                  //         element.date ==
                                  //         calenderScehudle
                                  //             .nextCalender![index].date)
                                  //     .toList();

                                  if (available(index)) {
                                    context
                                        .read<EventProvider>()
                                        .selectDay(index);
                                    context
                                        .read<EventProvider>()
                                        .setSchedule(currentSchedule.first);


                        
                                  } else {
                                    showToast(context,
                                        "No meal has been set for this day");
                                  }

                                  if (calenderScehudle
                                      .presentCalender![index].date!
                                      .isBefore(DateTime.now())) {
                                    print("cant edit anymore");
                                  }
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Day ${index + 1}"),
                                              SizedBox(height: 15),
                                              appListener.nextWeek == 0
                                                  ? Text(
                                                      "${formatDate(calenderScehudle.presentCalender![index].date!)}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                                  : Text(
                                                      "${formatDate(calenderScehudle.nextCalender![index].date!)}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                            ],
                                          ),
                                          ElasticIn(
                                            child: available(index)
                                                ? Icon(
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )
                                                : Container(
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          eventListener.selectedIndex == index
                              ? Column(
                                  children: [


                                    SlideInLeft(
                                        child: mealSpecific(context, () {
                                      context.read<EventProvider>().markIntrest(
                                          context,
                                          IntrestModel(
                                              timetable: eventListener.activeSchedule!.id,
                                              meal: eventListener.activeSchedule!.breakfast,
                                              date: eventListener.activeSchedule!.date,
                                              ));
                                    },
                                            eventListener.activeSchedule!
                                                    .breakfast!,
                                               eventListener.userIntrest
                                                    .where((element) =>
                                                        element.meal ==
                                                            eventListener
                                                                .activeSchedule!
                                                                .breakfast &&
                                                        element.date ==
                                                            eventListener
                                                                .activeSchedule!
                                                                .date)
                                                    .toList().isEmpty
                                                ? false
                                                : true,
                                                )),


                                    SlideInRight(
                                        child: mealSpecific(context, () {
                                      context.read<EventProvider>().markIntrest(context,
                                          IntrestModel(
                                              timetable: eventListener.activeSchedule!.id,
                                              meal: eventListener.activeSchedule!.lunch,
                                              date: eventListener.activeSchedule!.date
                                              ));
                                              },
                                            eventListener.activeSchedule!.lunch!,
                                            eventListener.userIntrest.where((element) => element.meal == eventListener.activeSchedule!
                                                                .lunch &&
                                                        element.date ==
                                                            eventListener
                                                                .activeSchedule!
                                                                .date)
                                                    .toList()
                                                    .isEmpty
                                                ? false
                                                : true,
                                                )),
                                    SlideInLeft(
                                        child: mealSpecific(context, () {
                                      context.read<EventProvider>().markIntrest(
                                          context,
                                          IntrestModel(
                                              timetable: eventListener
                                                  .activeSchedule!.id,
                                              meal: eventListener
                                                  .activeSchedule!.dinner,
                                              date: eventListener
                                                  .activeSchedule!.date));
                                    },
                                            eventListener
                                                    .activeSchedule!.dinner!,
                                            eventListener.userIntrest
                                                    .where((element) =>
                                                        element.meal ==
                                                            eventListener
                                                                .activeSchedule!
                                                                .dinner &&
                                                        element.date ==
                                                            eventListener
                                                                .activeSchedule!
                                                                .date)
                                                    .toList()
                                                    .isEmpty
                                                ? false
                                                : true))
                                  ],
                                )
                              : SizedBox()
                        ],
                      );
                      
                      
                  }
                  
               
                      
                      
                      ),
              SizedBox(
                height: eventListener.selectedIndex >= 0
                    ? AppSize.height(2)
                    : AppSize.height(10),
              ),

              !eventListener.edited
                  ? Container()
                  : BounceInDown(
                      child: AppButton(
                      pressed: eventListener.processingTransfer,
                      onPress: () {
                        context.read<EventProvider>().saveIntrest(context);
                      },
                      title: "SAVE",
                      primary: true,
                    )),
            ],
          ),
        ),
      )),
    );
  }

  mealSpecific(
      BuildContext context, Function()? onTap, String label, bool status) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(3), vertical: AppSize.width(3)),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border:
                Border.all(color: Theme.of(context).scaffoldBackgroundColor),
            // border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            status 
                ? Icon(
                    Icons.check_box,
                    color: AppColors.primary,
                  )
                : Icon(Icons.check_box_outline_blank_outlined)
          ],
        ),
      ),
    );
  }
}

