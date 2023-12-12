import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/history.screen.dart';
import 'package:promeal/screen/home.screen.dart';
import 'package:promeal/screen/setting.screen.dart';
import 'package:promeal/screen/users.screen.dart';
import 'package:promeal/screen/widgets/appbar.widget.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {


    const List<String> title = ["DASHBOARD", "USERS", "HISTORY", "SETTINGS"];

    const List<Widget> screens = [HomeScreen(), UserScreen(),HistoryScreen(), SettingScreen(),];

    final appListener = context.watch<AppProvider>();

    return Scaffold(
        appBar: customAppBar(context, title: title[appListener.bottomNavIndex]),
        body: screens[appListener.bottomNavIndex],

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  color: Theme.of(context).shadowColor.withOpacity(0.5))
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          padding: EdgeInsets.only(
              left: AppSize.width(4),
              right: AppSize.width(4),
              top: AppSize.height(2)),
          height: AppSize.height(13),
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.9),
                                  )),
                            ],
                          ),
                        ))
            ],
          ),
        ));
  }
}
