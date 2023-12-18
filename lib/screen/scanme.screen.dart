import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanMeScreen extends StatelessWidget {
  const ScanMeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();

    String generateRandomString({int length = 21}) {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      Random rnd = Random();
      return String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.height(5)),
        FadeInDown(
          child: Center(
            child: Extrude(
              pressed: appListener.admin,
              onPress: () {
                context.read<AppProvider>().toggleScanTab();
              },
              child: SizedBox(
                width: AppSize.width(70),
                height: AppSize.width(70),
                child: QrImageView(
                  data: appListener.admin
                      ? "claim_${generateRandomString()}"
                      : context.read<AccountProvider>().accountModel!.key ??
                          "unknown",
                  version: QrVersions.auto,
                  eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                  dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                  size: 320,
                  gapless: false,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.height(2)),
        SizedBox(
            width: AppSize.width(68),
            child: Column(
              children: [
                AnimatedTextKit(
                  pause: const Duration(seconds: 40),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Scan Me! To securedly claim your meal",
                      textStyle: AppStyle.apply(context),
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  onTap: () {},
                ),
                SizedBox(height: AppSize.height(2)),
              ],
            )),
        const Spacer(),
      ],
    );
  }
}
