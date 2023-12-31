import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/home.screen.dart';
import 'package:promeal/screen/notification.screen.dart';
import 'package:promeal/screen/scanme.screen.dart';
import 'package:promeal/screen/setting.screen.dart';
import 'package:promeal/screen/users.screen.dart';
import 'package:promeal/screen/widgets/appbar.widget.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    const List<String> title = [
      "DASHBOARD",
      "USERS",
      "SCAN ME",
      "NOTIFICATION",
      "SETTINGS",
    ];

    const List<Widget> screens = [
      // ChefHomeScreen(),
      HomeScreen(),
      UserScreen(),
      ScanMeScreen(),
      NotificationScreen(),
      SettingScreen(),
    ];

    final appListener = context.watch<AppProvider>();

    double notchRadius = 60;

    return Scaffold(
        appBar: customAppBar(context, title: title[appListener.bottomNavIndex]),
        body: screens[appListener.bottomNavIndex],
        floatingActionButton: bottomIsNew
            ? appListener.bottomNavIndex == 2
                ? JelloIn(
                    child:  SizedBox(
                      width: notchRadius,
                      height: notchRadius,
                      child: Extrude(
                        primary: true,
                        radius: 100,
                        child: SizedBox(
                          width: notchRadius,
                          height: notchRadius,
                          child: const Icon(
                            Icons.qr_code_2,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: notchRadius,
                    height: notchRadius,
                    child: Extrude(
                      onPress: () {
                        context.read<AppProvider>().toggleBottomNav(2);
                      },
                      radius: 100,
                      child:  SizedBox(
                        width: notchRadius,
                        height: notchRadius,
                        child: Icon(
                          Icons.qr_code_2,
                          size: 30,
                          color:  Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                        ),
                      ),
                    ),
                  )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomIsNew ? bottomNavDocked(context, appListener) : bottomNavOld(context, appListener));
  }

  bottomNavOld(BuildContext context, AppProvider appListener) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(spreadRadius: 0.1, blurRadius: 1, color: Theme.of(context).shadowColor.withOpacity(0.5))],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.only(left: AppSize.width(4), right: AppSize.width(4), top: AppSize.height(1)),
      height: AppSize.height(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              bottom.length,
              (index) => appListener.bottomNavIndex == index
                  ? JelloIn(
                      child: Extrude(
                          pressed: true,
                          primary: true,
                          child: SizedBox(
                            width: bottomNav,
                            height: bottomNav,
                            child: Icon(
                              bottom[index],
                              size: appbar - 4,
                              color: Colors.white,
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        context.read<AppProvider>().toggleBottomNav(index);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                              width: bottomNav,
                              height: bottomNav,
                              child: Icon(
                                bottom[index],
                                size: appbar - 4,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.9),
                              )),
                        ],
                      ),
                    ))
        ],
      ),
    );
  }

  bottomNavDocked(BuildContext context, AppProvider appListener) {
    return BottomAppBar(
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: const CircularNotchedRectangle(), //shape of notch
      elevation: 33,
      notchMargin: 6,

      child: Row(
        /*--------------------------------
        children inside bottom appbar
        -------------------------------*/
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ...List.generate(
            bottom.length,
            (index) => index == 2
                ? Container(width: 35)
                : appListener.bottomNavIndex == index
                    ? JelloIn(
                        child: GestureDetector(
                          onTap: () {
                            context.read<AppProvider>().toggleBottomNav(index);
                          },
                          child: SizedBox(
                            width: bottomNav,
                            height: bottomNav,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 7,
                                ),

                                Image(
                                  image: AssetImage(appListener.bottomNavIndex != index ? bottomPic[index] : bottomFillPic[index]),
                                  width: appbar - 6,
                                )
                                // Icon(
                                //   appListener.bottomNavIndex == index ? bottomFill[index] : bottom[index],
                                //   size: appbar,
                                //   color: appListener.bottomNavIndex == index ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          context.read<AppProvider>().toggleBottomNav(index);
                        },
                        child: SizedBox(
                          width: bottomNav,
                          height: bottomNav,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),

                              Image(
                                image: AssetImage(bottomPic[index]),
                                width: appbar - 6,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                              )
                              // Icon(
                              //   appListener.bottomNavIndex == index ? bottomFill[index] : bottom[index],
                              //   size: appbar,
                              //   color: appListener.bottomNavIndex == index ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                              // ),
                            ],
                          ),
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
