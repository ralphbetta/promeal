import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanClaimScreen extends StatefulWidget {
  final String meal;
  const ScanClaimScreen({super.key, required this.meal});

  @override
  State<ScanClaimScreen> createState() => _ScanClaimScreenState();
}

class _ScanClaimScreenState extends State<ScanClaimScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  bool validateData(String data) {
    List<String> code = data.split("_");
    String first = code.first;
    String last = code.last;

    if (first != 'claim') {
      return false;
    }

    if (last.length < 21 || last.length > 21) {
      return false;
    }

    return true;
  }

  bool isCodeScanned = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isCodeScanned && result != null) {
        isCodeScanned = true;
        controller.stopCamera();

        bool isValid = validateData(scanData.code ?? "");
        
        if(isValid){
          Map body = {"meal": widget.meal};
          context.read<EventProvider>().claim(context, body);
        }else{
          showStatus(context, () => {}, message: "Invalid Claim Code");
        }

   
      }

      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
          FadeInDown(
            child: Extrude(
              radius: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade400,
                ),
                margin: const EdgeInsets.all(15),
                width: AppSize.width(70),
                height: AppSize.width(70),
                child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.height(3),
          ),
          SizedBox(
              width: AppSize.width(58),
              child: Column(
                children: [

                  AnimatedTextKit(
                  pause: const Duration(seconds: 40),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Align the QR code within the frame to scan & Claim",
                      textStyle: AppStyle.apply(context),
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  onTap: () {},
                ),
                 
                  SizedBox(
                    height: AppSize.height(3),
                  ),
                  context.watch<EventProvider>().processingTransfer
                      ? Center(
                          child: Text(
                          "Processing Claim...",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))
                      : Center(
                          child: (result != null) ? Text("Done!") : Text(''),
                        ),
                ],
              )),
          const Spacer(),
          BounceInUp(
            child: Extrude(
              onPress: () {
                // print("Hellow ${controller!.getFlashStatus().then((value) => null)}");
                controller!.toggleFlash();
              },
              primary: true,
              radius: 8,
              child: SizedBox(
                width: appbar + 5,
                height: appbar + 5,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Image(image: AssetImage(AppAsset.touch)),
                )
                 
              ),
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
