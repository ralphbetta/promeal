import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Container(),
          actions: [
            SizedBox(width: AppSize.width(4)),
            Row(
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
          Extrude(
            radius: 22.72,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade400,
              ),
              margin: const EdgeInsets.all(15),
              width: AppSize.width(60),
              height: AppSize.width(60),
            ),
          ),
          SizedBox(
            height: AppSize.height(3),
          ),
          SizedBox(
              width: AppSize.width(58),
              child: const Text(
                "Align the QR code within the frame to scan",
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          Extrude(
            onPress: () {
              Navigator.pop(context);
            },
            primary: true,
            radius: 8,
            child: const SizedBox(
              width: appbar + 5,
              height: appbar+5,
              child: Icon(Icons.light_mode, color: Colors.white),
            ),
          ),
            SizedBox(
            height: AppSize.height(5),
          ),
        ],
      )),
    );
  }
}
