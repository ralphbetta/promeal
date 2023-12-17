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

  String _meal = "";
  String get meal => _meal;
  List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];

  setMeal(int index) {
    _meal = meals[index];
    notifyListeners();
  }

  transfer(
    BuildContext context,
    Map body,
  ) async {

    Response response = await APIRepo().transfer(body, context.read<AccountProvider>().token);

    print("this is the response $response");

    if (response.statusCode == 200) {
      showStatus(context, () => {}, message: "Your meal has been transferred successfully.", success: true);
    } else {
      showStatus(context, () => {}, message: response.data['message']);
    }
  }

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

    if (!context.mounted) {
      notifyListeners();
    }
  }
}
