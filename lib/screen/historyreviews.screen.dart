import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/history.model.dart';

class HistoryReviewScreens extends StatefulWidget {
  final List<Review> reviews;
  const HistoryReviewScreens({super.key, required this.reviews});

  @override
  State<HistoryReviewScreens> createState() => _HistoryReviewScreensState();
}

class _HistoryReviewScreensState extends State<HistoryReviewScreens> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
   
    List<String> mclass = ["All", "Breakfast", "Lunch", "Dinner"];
    List<List<Review>> counts = [
      widget.reviews,
      widget.reviews.where((element) => element.mclass == "Breakfast").toList(),
      widget.reviews.where((element) => element.mclass == "Lunch").toList(),
      widget.reviews.where((element) => element.mclass == "Dinner").toList()
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
                Text("History Reviews".toUpperCase(),
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
              height: AppSize.height(2),
            ),
            Container(
              height: AppSize.height(10),
              width: double.infinity,
              child: ListView.builder(
                  itemCount: mclass.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return ElasticIn(
                      delay: Duration(milliseconds: 1 * 100),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Extrude(
                            primary: selectedIndex == index ? true : false,
                            pressed: selectedIndex == index ? true : false,
                            onPress: () {
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
                                  Text(
                                    counts[index].length.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : null),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    mclass[index],
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : null),
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: AppSize.height(2),
            ),

            Column(
              children: [
            ...List.generate(counts[selectedIndex].length, (index) {
        
              return SlideInUp(
                duration: Duration(milliseconds: animationDelay * index + 1),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${counts[selectedIndex][index].name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              ...List.generate(
                                  5,
                                  (xindex) => SlideInDown(
                                        duration: Duration(
                                            milliseconds: 100 * xindex),
                                        child: Icon(
                                          Icons.star,
                                          size: 19,
                                          color: counts[selectedIndex][index]
                                                      .rating! <=
                                                  xindex
                                              ? Theme.of(context).hintColor
                                              : Colors.deepOrangeAccent,
                                        ),
                                      ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),


                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${counts[selectedIndex][index].review}", style: AppStyle.apply(context, size: 15)),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Text(
                                counts[selectedIndex][index].mclass!,
                                style: TextStyle(color: Colors.white),
                              )),
                          SizedBox(width: 5),
                          Text("${counts[selectedIndex][index].meal}")
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              );
            }),
        
              ],
            )

          ],
        ),
      )),
    );
  }
}
