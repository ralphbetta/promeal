import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/model/intrest.model.dart';
import 'package:promeal/model/mealcaldender.model.dart';
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

  int selectedIndex = -1;
  Schedule? activeSchedule = null;

  setSchedule(Schedule newSchedule) {
    activeSchedule = newSchedule;
    notifyListeners();
  }

  ScheduleModel? _mealCalender;
  ScheduleModel? get mealCalender => _mealCalender;

  Schedule? _schedule;
  Schedule? get schedule => _schedule;

  List<IntrestModel> _userIntrest = [];
  List<IntrestModel> get userIntrest => _userIntrest;

  List<IntrestModel> _weeklyIntrest = [];
  List<IntrestModel> get weeklyIntrest => _weeklyIntrest;

  bool edited = false;

  final socket = SocketService.instance.socket;


  selectDay(int newIndex) {
    if (selectedIndex == newIndex) {
      selectedIndex = -1;
    } else {
      selectedIndex = newIndex;
    }
    notifyListeners();
  }

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

    print("this is the response $response from $payload");

    if (response.statusCode == 200) {
      AppRoutes.irreversibleNavigate(context, Dashboard());

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
      AppRoutes.irreversibleNavigate(context, Dashboard());
      AppRoutes.push(context, MealActionScreen());
      showStatus(context, () => {}, message: response.data['message']);
    }
    toggleBusy();
  }

  monitorTransfer(BuildContext context) {
    if (!_monitoring) {
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

        if (context.read<AccountProvider>().allowNotification) {
          playNotification();
        }

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

  playNotification() {
    print("play");
    AudioPlayer player = new AudioPlayer();
    String tone2 = "bell.wav";
    // String tone1 = "hat.wav";
    // String tone3 = "tone.wav";

    player.play(AssetSource(tone2), volume: 0.1);
  }

  postSchedule(BuildContext context, currentWeek, {int day = 1}) async {
    if (breakfastController.text.isEmpty ||
        luchController.text.isEmpty ||
        dinnerController.text.isEmpty) {
      showToast(context, "All the fields are required");
      return false;
    }

    toggleBusy();

    Map body = {
      "breakfast": breakfastController.text,
      "lunch": luchController.text,
      "dinner": dinnerController.text,
      "day": day,
      "currentWeek": currentWeek
    };

    Response response =
        await APIRepo().postMeal(body, context.read<AccountProvider>().token);

    await fetchSchedule(context);

    showToast(context, response.data['message']);

    Navigator.pop(context);

    toggleBusy();
  }

  completeEdit() {
    edited = false;
    notifyListeners();
  }

  saveIntrest(BuildContext context) async {

    toggleBusy();

    DateTime startDate =
        _mealCalender!.presentCalender!.first.date!.subtract(Duration(days: 1));;
    DateTime endDate =
        _mealCalender!.presentCalender!.last.date!.add(Duration(days: 1));

    List<IntrestModel> intrestRange = _userIntrest
        .where((element) =>
            element.date!.isAfter(startDate) && element.date!.isBefore(endDate))
        .toList();

    List<Map> body = [
      ...List.generate(
          intrestRange.length,
          (index) => {
                "timetable": intrestRange[index].timetable,
                "meal": intrestRange[index].meal,
                "date": intrestRange[index].date.toString(),
                "checked": true
              }),
      ...List.generate(
          _userIntrestTrash.length,
          (index) => {
                "timetable": _userIntrestTrash[index].timetable,
                "meal": _userIntrestTrash[index].meal,
                "date": _userIntrestTrash[index].date.toString(),
                "checked": false
              }),
    ];


    Response response = await APIRepo().postIntrest(body, context.read<AccountProvider>().token);

    if (response.statusCode == 200) {
      intrestRange.clear();
      _userIntrest.clear();
      _userIntrestTrash.clear();
      for (var item in response.data['data']) {
        IntrestModel instance = IntrestModel.fromJson(item);
        _userIntrest.add(instance);
      }
      notifyListeners();
      showToast(context, response.data['message']);
    }

    toggleBusy();
  }

  List<IntrestModel> _userIntrestTrash = [];

  markIntrest(BuildContext context, IntrestModel body) async {

    int intrestIndex = _userIntrest.indexWhere((element) =>
        element.meal == body.meal &&
        element.date == body.date &&
        element.timetable == body.timetable);

    int trashintrestIndex = _userIntrestTrash.indexWhere((element) =>
        element.meal == body.meal &&
        element.date == body.date &&
        element.timetable == body.timetable);
    if (intrestIndex >= 0) {
      
      print(_userIntrest[intrestIndex].toJson());
      print(body.toJson());

      _userIntrestTrash.add(_userIntrest[intrestIndex]);
      _userIntrest.removeAt(intrestIndex);
      print("found");
    } else {
      if (trashintrestIndex >= 0) {
        _userIntrestTrash.removeAt(trashintrestIndex);
      }
      _userIntrest.add(body);
      print("not found");
    }
    ;

    edited = true;

    print("intrestIndex $intrestIndex, trashIndex $trashintrestIndex userIntrest ${_userIntrest.length} trashedIntrest ${_userIntrestTrash.length}");


    notifyListeners();
  }

  fetchUserIntrest(BuildContext context) async {
    Response response =
        await APIRepo().userIntrest(context.read<AccountProvider>().token);
    _userIntrest.clear();
    for (var item in response.data['data']) {
      IntrestModel instance = IntrestModel.fromJson(item);
      _userIntrest.add(instance);
    }
    notifyListeners();

    print("This are the indicated intrest ${_userIntrest.length}");
    return true;
  }

  fetchWeeklyUserIntrest(BuildContext context) async {
    Response response =
        await APIRepo().weeklyIntrest(context.read<AccountProvider>().token);
    _weeklyIntrest.clear();
    for (var item in response.data['data']) {
      IntrestModel instance = IntrestModel.fromJson(item);
      _weeklyIntrest.add(instance);
    }
    notifyListeners();

    print("This are the indicated intrest ${_userIntrest.length}");
    return true;
  }

  fetchSchedule(BuildContext context) async {
    Response response =
        await APIRepo().getMealCalender(context.read<AccountProvider>().token);

    ScheduleModel instance = ScheduleModel.fromJson(response.data['data']);

    _mealCalender = instance;

    // ------------------- Today's schedule

    DateTime currentData = DateTime.now();
    // DateTime increasedDate = currentData.add(Duration(days: 1));

    List<Schedule> value = _mealCalender!.schedules!
        .where((element) =>
            element.date!.add(Duration(days: 1)).day == currentData.day)
        .toList();

    if (value.isNotEmpty) {
      _schedule = value.first;
    }

    // ------------------------------------

    notifyListeners();

    return true;
  }

  initLoading(BuildContext context){
    fetchSchedule(context);
    fetchUserIntrest(context);
    fetchWeeklyUserIntrest(context);
  }

  // List<DateModel> dateTimeLineList = [];

  // void getDate() {
  //   for (int i = -7; i < 7; i++) {
  //     String month = DateFormat('LLL')
  //         .format(DateTime.now().add(Duration(days: i)))
  //         .toUpperCase();

  //     String day =
  //         DateFormat('d').format(DateTime.now().add(Duration(days: i)));

  //     String weekDay = DateFormat('E')
  //         .format(DateTime.now().add(Duration(days: i)))
  //         .toUpperCase();

  //     String date = DateFormat('yyyy-MM-dd')
  //         .format(DateTime.now().add(Duration(days: i)));

  //     DateModel dateModel =
  //         DateModel(weekDay: weekDay, day: day, month: month, date: date);

  //     dateTimeLineList.add(dateModel);
  //   }

  //   notifyListeners();
  // }

  init() {}
}
