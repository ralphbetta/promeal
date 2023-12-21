import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';

Future<void> showScannedSuccess(context, Function()? onTap,
    {String message = ""}) async {
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
                color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage(AppAsset.scanned),
                    gaplessPlayback: false,
                  ),
                  SizedBox(height: AppSize.height(1)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(4),
                        vertical: AppSize.width(2)),
                    child: Text(message,
                        textAlign: TextAlign.center,
                        style: AppStyle.apply(context)),
                  ),
                  SizedBox(height: AppSize.height(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
                    child: Extrude(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(child: Text("CONTINUE")),
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

Future<void> showStatus(context, Function()? onTap,
    {String message = "", bool success = false}) async {
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
                color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //dex

                  success
                      ? Image(
                          image: AssetImage(AppAsset.pass),
                          height: AppSize.height(20),
                        )
                      : Image(
                          image: AssetImage(AppAsset.fail),
                          height: AppSize.height(20)),

                  SizedBox(height: AppSize.height(1)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(4),
                        vertical: AppSize.width(2)),
                    child: Text(message,
                        textAlign: TextAlign.center,
                        style: AppStyle.apply(context)),
                  ),
                  SizedBox(height: AppSize.height(2)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
                    child: success
                        ? Extrude(
                            primary: true,
                            onPress: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                  child: success
                                      ? const Text("CONTINUE",
                                          style: TextStyle(color: Colors.white))
                                      : Text(
                                          "TRY AGAIN",
                                          style: AppStyle.apply(context,
                                              color: Colors.white),
                                        )),
                            ),
                          )
                        : GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: -Offset(4, 4),
                                      color:
                                          Theme.of(context).secondaryHeaderColor,
                                      blurRadius: 10,
                                    ),
                                    //bottom region
                                    BoxShadow(
                                      offset: Offset(4, 4),
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 10,
                                    ),
                                  ]),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "TRY AGAIN",
                                      style: AppStyle.apply(context,
                                          color: Colors.white),
                                    ),
                                  ))),
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

Future<void> showFoodDrop(context, Function()? onTap,
    {String message = ""}) async {
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
                color: Theme.of(context).colorScheme.background),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage(AppAsset.celebrate),
                    gaplessPlayback: false,
                  ),
                  Text(
                    "Woo-hoo!",
                    style: AppStyle.apply(context,
                        size: 24, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(4),
                        vertical: AppSize.width(2)),
                    child: Text(message,
                        textAlign: TextAlign.center,
                        style: AppStyle.apply(context)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
                    child: Extrude(
                      primary: true,
                      onPress: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text("CONTINUE",
                                style: TextStyle(color: Colors.white))),
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

Future<void> showConfirmTransfer(context, Function()? onTap,
    {String message = ""}) async {
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
                color: Theme.of(context).colorScheme.background),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSize.height(5)),
                  Text(
                    "Are you sure?",
                    style: AppStyle.apply(context,
                        size: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: AppSize.height(1)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(4),
                        vertical: AppSize.width(2)),
                    child: Text(message,
                        textAlign: TextAlign.center,
                        style: AppStyle.apply(context)),
                  ),
                  SizedBox(height: AppSize.height(4)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.width(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Extrude(
                          onPress: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 40,
                            child: Center(
                                child: Text(
                              "NO",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color),
                            )),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Extrude(
                          primary: true,
                          onPress: onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 40,
                            child: const Center(
                                child: Text(
                              "YES",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
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
