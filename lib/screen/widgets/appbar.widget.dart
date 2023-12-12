  import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/config/theme.config.dart';

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
              Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(title.toUpperCase(),
                      style: AppStyle.apply(context,
                          fontWeight: FontWeight.w700, size: 18))),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Extrude(
                onPress: () {
                  AppTheme().switchTheme();
                },
                primary: true,
                radius: 8,
                child: SizedBox(
                  width: appbar + 5,
                  height: appbar,
                  child: Icon(
                    Icons.brightness_2_outlined,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Extrude(
                primary: true,
                radius: 8,
                child: SizedBox(
                  width: appbar + 5,
                  height: appbar,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: AppSize.width(4)),
        ],
        elevation: 0.9,
        shadowColor: Theme.of(context).colorScheme.background);
  }

