import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/screen/scan.screen.dart';
import 'package:promeal/screen/widgets/foodcounter.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, index) {
                return FadeInUp(
                    delay: Duration(milliseconds: index * 30),
                    child: MealCard(meal: meals[index]));
              }),
        ),
      ],
    );
  }
}

class MealCard extends StatelessWidget {
  final String meal;
  const MealCard({
    super.key,
    this.meal = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: AppSize.height(3),
          left: AppSize.width(4),
          right: AppSize.width(4)),
      child: Extrude(
        onPress: (){
          AppRoutes.push(context, const ScanScreen());
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
                  Text(
                    meal.toUpperCase(),
                    style: AppStyle.apply(context,
                        fontWeight: FontWeight.w600, size: 18),
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
                        "Itepu Mabel",
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
