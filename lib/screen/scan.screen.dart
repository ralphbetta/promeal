import 'dart:io';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
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
          Extrude(
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
          SizedBox(
            height: AppSize.height(3),
          ),
          SizedBox(
              width: AppSize.width(58),
              child: Column(
                children: const [
                  Text(
                    "Align the QR code within the frame to scan",
                    textAlign: TextAlign.center,
                  ),

                  //        Center(
                  //   child: (result != null)
                  //       ? Text(
                  //           'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  //       : Text('Scan a code'),
                  // ),
                ],
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
              height: appbar + 5,
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
