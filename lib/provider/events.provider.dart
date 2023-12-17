import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier{

    final socket = SocketService.instance.socket;

    monitorTransfer(BuildContext context){

      socket.on("userNotice", (data){

        log(data.toString());

        context.read<AppProvider>().checkBox();

        showFoodDrop(context, () => null, message: data['data']);


      });
    }


}