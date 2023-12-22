import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/screen/dashboard.screen.dart';
import 'package:promeal/screen/meal.action.screen.dart';
import 'package:promeal/services/api.service.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:promeal/utils/toast.utils.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier {
  bool _monitoring = false;
  bool get monitoring => _monitoring;

  String _sender = "";
  String get sender => _sender;

  setSender({String email = ""}) {
    _sender = email;
    notifyListeners();
  }

  bool _processingTransfer = false;
  bool get processingTransfer => _processingTransfer;

  toggleBusy() {
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

  setMealString(String data) {
    _meal = data;
    notifyListeners();
  }

  transfer(BuildContext context, Map body) async {
    toggleBusy();
    Response response =
        await APIRepo().transfer(body, context.read<AccountProvider>().token);

    if (response.statusCode == 200) {
      showStatus(context, () => {},
          message: "Your meal has been transferred successfully.",
          success: true);
      context
          .read<AccountProvider>()
          .loadNotification(context.read<AccountProvider>().token);
    } else {
      showStatus(context, () => {}, message: response.data['message']);
    }
    toggleBusy();
  }

  claim(BuildContext context, Map body, {bool forfeited = false}) async {
    toggleBusy();

    Map payload = {"meal": meal, 'email': _sender, 'forfeited': forfeited};

    Response response;

    if (_sender == "") {
      response =
          await APIRepo().claim(body, context.read<AccountProvider>().token);
    } else {
      response = await APIRepo()
          .claimTransfer(payload, context.read<AccountProvider>().token);
    }

    AppRoutes.irreversibleNavigate(context, Dashboard());
    AppRoutes.push(context, MealActionScreen());

    print("this is the response $response from $payload");

    if (response.statusCode == 200) {
      if (forfeited) {
        showStatus(context, () => {},
            message: "Your meal has been Forfeited", success: true);
      } else {
        showStatus(context, () => {},
            message: "Your meal has been claimed", success: true);
      }

      context
          .read<AccountProvider>()
          .loadNotification(context.read<AccountProvider>().token);
    } else {
      showStatus(context, () => {}, message: response.data['message']);
    }
    toggleBusy();
  }

  final socket = SocketService.instance.socket;

  monitorTransfer(BuildContext context) {
    if (!_monitoring) {
      log("user monitoring inprogress...");
      socket.on("userNotice", (data) {
        log(data.toString());
        String token = context.read<AccountProvider>().token;
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

  adminMonitor(BuildContext context) {
    if (!_monitoring) {
      log("admin monitoring inprogress...");
      socket.on("monitor", (data) {
        log(data.toString());
        showToast(context, data['message']);
        String token = context.read<AccountProvider>().token;
        context.read<AccountProvider>().initLoading(token, 'admin');
      });

      _monitoring = true;
    }

    if (!context.mounted) {
      notifyListeners();
    }
  }

  void playNotification() {
    print("play");
    AudioPlayer player = new AudioPlayer();
    String tone2 = "bell.wav";
    String tone1 = "hat.wav";
    String tone3 = "tone.wav";

    player.play(AssetSource(tone2), volume: 0.1);
  }
}
