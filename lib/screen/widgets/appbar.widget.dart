  import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/config/theme.config.dart';
import 'package:promeal/provider/theme.provider.dart';

customAppBar(BuildContext context, {String title=""}) {
  const double appbar = 37;
    return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          SizedBox(width: AppSize.width(4)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title.toUpperCase(),
                  style: AppStyle.apply(context,
                      fontWeight: FontWeight.w700, size: 18)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Padding(
               padding: const EdgeInsets.only(
                  top: 6
                ),
                child: Extrude(
                  onPress: () {
                    AppTheme().switchTheme();
                  },
                  primary: true,
                  radius: 8,
                  child:  SizedBox(
                    width: appbar + 5,
                    height: appbar,
                    child: Icon(
                      ThemeClass.themeNotifier.value == ThemeMode.dark ? Icons.brightness_2_outlined : Icons.brightness_4_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(width: 20),
          // Row(
          //   children:  [
          //     Padding(
          //       padding: const EdgeInsets.only(
          //         top: 6
          //       ),
          //       child: Extrude(
          //         onPress: (){
          //           context.read<AppProvider>().toggleBottomNav(4);
          //         },
          //         primary: context.watch<AppProvider>().bottomNavIndex == 4 ? true: false,
          //         radius: 8,
          //         child: const SizedBox(
          //           width: appbar + 5,
          //           height: appbar,
          //           child: Icon(
          //             Icons.notifications_outlined,
          //             color: Colors.white
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(width: AppSize.width(4)),
        ],
        elevation: 0.9,
        shadowColor: Theme.of(context).colorScheme.background);
  }

