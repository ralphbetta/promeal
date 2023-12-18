import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/services/api.service.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier {
  bool _monitoring = false;
  bool get monitoring => _monitoring;

  bool _processingTransfer = false;
  bool get processingTransfer => _processingTransfer;

  processTransfer() {
    _processingTransfer = !_processingTransfer;
    notifyListeners();
  }

  String _meal = "";
  String get meal => _meal;
  List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];

  setMeal(int index) {
    _meal = meals[index];
    notifyListeners();
  }

  transfer(BuildContext context, Map body) async {
    processTransfer();
    Response response = await APIRepo().transfer(body, context.read<AccountProvider>().token);

    if (response.statusCode == 200) {
      showStatus(context, () => {}, message: "Your meal has been transferred successfully.", success: true);
    } else {
      showStatus(context, () => {}, message: response.data['message']);
    }
    processTransfer();
  }


  claim(BuildContext context, Map body) async {

    processTransfer();

    Response response = await APIRepo().claim(body, context.read<AccountProvider>().token);

    print("this is the response $response");

    if (response.statusCode == 200) {
      showStatus(context, () => {}, message: "Your meal has been transferred successfully.", success: true);
    } else {
      showStatus(context, () => {}, message: response.data['message']);
    }
    processTransfer();
  }


  final socket = SocketService.instance.socket;

  monitorTransfer(BuildContext context) {
    if (!_monitoring) {
      socket.on("userNotice", (data) {
        log(data.toString());

      String token =  context.read<AccountProvider>().token;
      context.read<AccountProvider>().loadNotification(token);
      context.read<AccountProvider>().loadTransfer(token);

        showFoodDrop(context, () => null, message: data['data']);
      });

      _monitoring = true;
    }

    if (!context.mounted) {
      notifyListeners();
    }
  }
}
