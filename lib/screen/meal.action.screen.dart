import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/scan.screen.dart';
import 'package:promeal/utils/toast.utils.dart';
import 'package:provider/provider.dart';

class MealActionScreen extends StatefulWidget {
  const MealActionScreen({super.key});

  @override
  State<MealActionScreen> createState() => _MealActionScreenState();
}

class _MealActionScreenState extends State<MealActionScreen> {
  final int delay = 400;
  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();

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
                    child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Actions".toUpperCase(), style: AppStyle.apply(context, fontWeight: FontWeight.w700, size: 18)),
              ],
            ),
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: AppSize.height(3),
          ),
          SlideInUp(
            duration: Duration(milliseconds: delay),
            child: mealActionCard(context, () {
              AppRoutes.push(context, const ScanScreen());
            }),
          ),
          SlideInUp(
            duration: Duration(milliseconds: delay * 2),
            child: mealActionCard(context, () {
              context.read<AppProvider>().toggleTransferOption();
            }, title: "Transfer Breakfast", icon: Icons.share, isOpen: appListener.transferIsOpen),
          ),
          appListener.transferIsOpen ? dropdownAction(context, appListener) : const SizedBox(),
          SlideInUp(
            duration: Duration(milliseconds: delay * 3),
            child: mealActionCard(context, () {}, title: "Forffeit Breakfast", icon: Icons.cancel_outlined),
          ),
          const Spacer(),

        appListener.transferIndex == null ? Container() : BounceInDown(
          child: Extrude(
            onPress: (){

              if(appListener.transferIndex == 1){
                 AppRoutes.push(context, const ScanScreen());
              }else{
                showToast(context, "Coming soon");
              }

            },
              radius: 100,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.arrow_forward),
              ),
            ),
        ),
          SizedBox(
            height: AppSize.height(10),
          ),
        ],
      )),
    );
  }
}

dropdownAction(BuildContext context, AppProvider appListener) {
  return Padding(
    padding: EdgeInsets.only(
      left: AppSize.width(4),
      right: AppSize.width(4),
      bottom: AppSize.width(4),
    ),
    child: Column(
      children: [
        SlideInLeft(
          child: GestureDetector(
            onTap: () {
              context.read<AppProvider>().selectTransferOption(1);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(2), vertical: 14),
              color: appListener.transferIndex == 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transfer via Scan",
                    style: TextStyle(
                      color: appListener.transferIndex == 1 ? Theme.of(context).colorScheme.background : Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    color: appListener.transferIndex == 1 ? Theme.of(context).colorScheme.background : Theme.of(context).textTheme.bodyLarge!.color,
                  )
                ],
              ),
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
        SlideInRight(
          child: GestureDetector(
            onTap: () {
              context.read<AppProvider>().selectTransferOption(2);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(2), vertical: 14),
              color: appListener.transferIndex == 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transfer via Search",
                    style: TextStyle(
                      color: appListener.transferIndex == 2 ? Theme.of(context).colorScheme.background : Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: appListener.transferIndex == 2 ? Theme.of(context).colorScheme.background : Theme.of(context).textTheme.bodyLarge!.color,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

mealActionCard(BuildContext context, Function()? onTap, {String title = "Claim Breakfask", bool isOpen = false, IconData icon = Icons.food_bank_outlined}) {
  return Padding(
    padding: EdgeInsets.only(left: AppSize.width(4), right: AppSize.width(4), bottom: 15),
    child: Extrude(
        onPress: onTap,
        radius: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4), vertical: 15),
          child: Row(
            children: [
              Text(title),
              const Spacer(),

              Icon(
                isOpen ? Icons.keyboard_arrow_down : Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                size: isOpen ? 30 : 20,
              )
              // Extrude(
              //   primary: true,
              //   child: SizedBox(
              //       width: appbar,
              //       height: appbar,
              //       child: Icon(
              //         icon,
              //         color: Colors.white,
              //       )),
              // )
            ],
          ),
        )),
  );
}
