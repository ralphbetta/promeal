import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.height(5)),
      

        /*-----------------------------------------------------------|
          TOGGLE SECTION
        |------------------------------------------------------------*/

        Center(
          child: Extrude(
            child: Container(
              width: AppSize.width(70),
              height: AppSize.width(70),
             
              child: QrImageView(
                data: 'This is a simple QR code',
                version: QrVersions.auto,
                eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: Theme.of(context).textTheme.bodyMedium!.color),
                dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Theme.of(context).textTheme.bodyMedium!.color),
                size: 320,
                gapless: false,
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.height(2)),
        SizedBox(
            width: AppSize.width(58),
            child: Column(
              children: [
                const Text(
                  "Scan Me! To securedly transfer your meal to me",
                  textAlign: TextAlign.center,
                ),

                  SizedBox(height: AppSize.height(2)),
                // Image(image: AssetImage(AppAsset.scanning))
              ],
            )),

        Spacer(),
      ],
    );
  }
}
