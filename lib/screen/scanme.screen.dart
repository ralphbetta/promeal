import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanMeScreen extends StatelessWidget {
  const ScanMeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.height(5)),
  

        Center(
          child: Extrude(
            child: SizedBox(
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

        const Spacer(),
      ],
    );
  }
}
