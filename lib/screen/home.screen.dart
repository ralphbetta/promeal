import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/model/mealcaldender.model.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/screen/meal.action.screen.dart';
import 'package:promeal/screen/staffmealcalender.screen.dart';
import 'package:promeal/screen/widgets/foodcounter.widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];

    return Column(
      children: [

        Padding(
          padding: EdgeInsets.only(
          top: AppSize.height(3),
          left: AppSize.width(4),
          right: AppSize.width(4)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Extrude(
                pressed: true,
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Icon(Icons.thumb_up_alt))),
              Extrude(
                onPress: (){
                  AppRoutes.push(context, StaffMealCalenderScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 10
                  ),
                  child: Text("Mark Intrested meals for the week"),
                ))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, index) {
                return FadeInUp(
                    delay: Duration(milliseconds: index * 30),
                    child: MealCard(meal: meals[index], index: index));
              }),
        ),
      ],
    );
  }
}

class MealCard extends StatelessWidget {
  final String meal;
  final int index;
  const MealCard({super.key, this.meal = "", required this.index});

  @override
  Widget build(BuildContext context) {
    Schedule schedule = context.watch<EventProvider>().schedule ??
        Schedule(breakfast: "None", lunch: "None", dinner: "None");

    List<String> data = [
      schedule.breakfast ?? "",
      schedule.lunch ?? "",
      schedule.dinner ?? ""
    ];

    return Container(
      margin: EdgeInsets.only(
          top: AppSize.height(3),
          left: AppSize.width(4),
          right: AppSize.width(4)
          ),
      child: Extrude(
          onPress: () {
            context.read<EventProvider>().setMeal(index);
            context.read<EventProvider>().setSender();
            AppRoutes.push(context, const MealActionScreen());
          },
          child: SizedBox(
            height: AppSize.height(18),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(5),
                vertical: AppSize.height(2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            meal.toUpperCase(),
                            style: AppStyle.apply(context,
                                fontWeight: FontWeight.w600, size: 18),
                          ),
                          Text(
                            " - ${data[index]}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Card Owner",
                              style: AppStyle.apply(context,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(height: 4),
                          Text(
                            "${context.read<AccountProvider>().accountModel!.name}",
                            style: AppStyle.apply(context,
                                fontWeight: FontWeight.w400, size: 20),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: const [
                          FoodcardCounter(),
                          SizedBox(width: 8),
                          FoodcardCounter(
                            trasfered: true,
                          ),
                          SizedBox(width: 10),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
