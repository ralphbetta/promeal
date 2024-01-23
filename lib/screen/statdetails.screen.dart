import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/intrest.model.dart';
import 'package:promeal/model/mealcaldender.model.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/utils/dateformat.utils.dart';
import 'package:provider/provider.dart';

class MealStatisticsDetails extends StatefulWidget {
  final DateTime date;
  const MealStatisticsDetails({super.key, required this.date});

  @override
  State<MealStatisticsDetails> createState() => _MealStatisticsDetailsState();
}

class _MealStatisticsDetailsState extends State<MealStatisticsDetails> {

  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    final appListener = context.watch<AppProvider>();
    ScheduleModel calenderScehudle =  context.watch<EventProvider>().mealCalender!;

  

    List<IntrestModel> event = context.watch<EventProvider>().weeklyIntrest;

    String count(DateTime date, {String mealclass = "Breakfast"}){

      List<IntrestModel> data  = event.where((element) => element.date!.isAtSameMomentAs(date)).toList();

      return data.length.toString();
    }

      List<String> mclass = ["All", "Breakfast", "Lunch", "Dinner"];
      List<List<IntrestModel>> counts = [
        event.where((element) => element.date!.isAtSameMomentAs(widget.date)).toList(),
        event.where((element) => element.mclass == "Breakfast" && element.date!.isAtSameMomentAs(widget.date)).toList(),
        event.where((element) => element.mclass == "Lunch" &&  element.date!.isAtSameMomentAs(widget.date)).toList(),
        event.where((element) => element.mclass == "Dinner" &&  element.date!.isAtSameMomentAs(widget.date)).toList()
      ];



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
                Text("Statistic Details".toUpperCase(),
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
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:
                 AppSize.height(2),
              ),
              
              Container(
                height: AppSize.height(10),
                width: double.infinity,
                child: ListView.builder(
                itemCount: mclass.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index){

            return ElasticIn(
              delay: Duration(milliseconds: 1 * 100),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 5,
                bottom: 5
              ),
              child: Extrude(
                primary: selectedIndex == index ? true: false,
                pressed: selectedIndex == index ? true: false,
                onPress: (){
                  selectedIndex = index;
                  setState(() {});
                },
              radius: 3,
              child: Container(
                width: AppSize.width(20),
                height: AppSize.width(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(counts[index].length.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: selectedIndex == index ? Colors.white : null),),
                    SizedBox(height: 5),
                    Text(mclass[index], style: TextStyle(fontSize: 10, color: selectedIndex == index ? Colors.white : null),)
                  ],
                ),
              )),
            ),
                );
                }),
                
              ),
              SizedBox(
                height:
                 AppSize.height(2),
              ),
          
          
              ...List.generate(
            counts[selectedIndex].length,
            (index){

              List<IntrestModel> event = context.watch<EventProvider>().weeklyIntrest;

              String count(DateTime date, {String mclass = "Breakfast"}){

               List<IntrestModel> data  = event.where((element) =>element.mclass == mclass && element.date!.isAtSameMomentAs(date)).toList();

                return data.length.toString();
              }

              return SlideInUp(
                  duration:
                      Duration(milliseconds: animationDelay * index + 1),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                        
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(counts[selectedIndex][index].account!.name!),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3
                                  ),
                                  child: Text(counts[selectedIndex][index].mclass!, style: TextStyle(color: Colors.white),))
                              ],
                            ),
                            Icon(Icons.star, color: Theme.of(context).primaryColor,)
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                );
                
                
            }
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
