import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier {
  bool _monitoring = false;
  bool get monitoring => _monitoring;

  final socket = SocketService.instance.socket;

  monitorTransfer(BuildContext context) {

    if (!_monitoring) {
      socket.on("userNotice", (data) {
        log(data.toString());

        context.read<AccountProvider>().token;

        showFoodDrop(context, () => null, message: data['data']);
      });

      _monitoring = true;
    }

   if(!context.mounted){
     notifyListeners();
   }

  }
}
