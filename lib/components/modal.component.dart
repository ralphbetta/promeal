
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';

Future<void> showModal(context, Function()? onTap, { bool show = true}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage(AppAsset.scanned), gaplessPlayback: false,),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.width(4)
                    ),
                    child:   Extrude(
                      onPress: (){
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width:  double.infinity,
                        height: 40,
                        child: Center(child: Text("Continue")),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20)
            
                ],
              ),
            ),
          ));
    },
  );
}
