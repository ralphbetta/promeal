import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/services/path.api.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("version ${packageInfo.version}");
    return packageInfo.version;
  }

  Future<String> getAppBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  Future<Map> getApiVersion() async {
    final url = APIRoute.app;

    http.Response response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }

  Future<void> checkAppVersion(BuildContext context) async {
    String appVersion = await getAppVersion();
    Map data = await getApiVersion();
    Map minimumVersion = data['data'];

    String appBuildNumber = await getAppBuildNumber();

    int api_v = getExtendedVersionNumber(minimumVersion['version']);
    int build_v = getExtendedVersionNumber(appVersion);

    if (api_v > build_v) {
      showUpdateApp(context, () => lunchStore(), message: 'A new version ${minimumVersion['version']} of Promeal App is available. Kindly Update', force: minimumVersion['forceUpdate']);
      // print("this is the minimum ${minimumVersion['version']}");
      // print("latest version ${api_v} - $build_v");
    } else if (int.parse(appBuildNumber) < minimumVersion['appBuildNumber']) {
        showUpdateApp(context, () => lunchStore(), message: 'A new version ${minimumVersion['version']} of Promeal App is available. Kindly Update', force: minimumVersion['forceUpdate']);
    } else {
      // print("latest version ${api_v} - $build_v");
      // print("build number $appBuildNumber");
    }
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }


  void lunchStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      
      // final appId = Platform.isAndroid
      //     ? 'com.cloudclinic.ng.cloudclinic_partner_app'
      //     : '1668991494';

      final url = Uri.parse(

        "https://raw.githubusercontent.com/ralphbetta/assets/main/promeal.apk"

        // Platform.isAndroid
        //     ? "market://details?id=$appId"
        //     : "https://apps.apple.com/app/id$appId",


      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}




Future<void> showUpdateApp(context, Function()? onTap,
    {String message = "", bool force = false}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
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
                  SizedBox(height: AppSize.height(2)),
                  Text(
                    "Update Required!",
                    style: AppStyle.apply(context,
                        size: 20, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
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
                        Visibility(
                          visible: !force,
                          child: Extrude(
                            radius: 5,
                            onPress: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: Center(
                                  child: Text(
                                "Later",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Extrude(
                          
                          primary: true,
                          onPress: onTap,
                          radius: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 40,
                            child: const Center(
                                child: Text(
                              "Update Now",
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
