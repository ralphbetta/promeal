import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/model/account.model.dart';
import 'package:promeal/model/adminfood.model.dart';
import 'package:promeal/model/admintransfer.model.dart';
import 'package:promeal/model/notification.model.dart';
import 'package:promeal/model/transfer.model.dart';
import 'package:promeal/screen/authscreen/auth.screen.dart';
import 'package:promeal/screen/dashboard.screen.dart';
import 'package:promeal/services/api.service.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:promeal/storage/local.storage.dart';
import 'package:promeal/utils/email_to_name.utils.dart';
import 'package:promeal/utils/toast.utils.dart';

class AccountProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _token = "";
  String get token => _token;

  AccountModel? _accountModel;
  AccountModel? get accountModel => _accountModel;

  List<AccountModel> _accounts = [];
  List<AccountModel> get accounts => _accounts;

  List<TransferModel> _transfers = [];
  List<TransferModel> get transfers => _transfers;

  List<AdminFoodModel> _adminfoodHistory = [];
  List<AdminFoodModel> get adminfoodHistory => _adminfoodHistory;

  List<AdminTransferModel> _admintransferHistory = [];
  List<AdminTransferModel> get admintransferHistory => _admintransferHistory;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  assignRole(int userId, context) async {
    int index = _accounts.indexWhere((element) => element.id == userId);
    _accounts[index].role = _accounts[index].role == 'user' ? 'admin' : 'user';
    notifyListeners();
    showToast(context, "Changing user role. Please wait....");
    Map<String, dynamic> payload = {"role": _accounts[index].role};
    Response response = await APIRepo().updateAccount(payload, token, accoundId: _accounts[index].id.toString());
    if (response.statusCode == 200) {
      _accounts[index].side = _accounts[index].side == 0 ? 1 : 0;
      showToast(context, "Role changed succesfully");
      notifyListeners();
    } else {
      _accounts[index].side = _accounts[index].side == 0 ? 1 : 0;
      _accounts[index].role = _accounts[index].role == 'user' ? 'admin' : 'user';
      showToast(context, "Role changed succesfully");
      notifyListeners();
    }
  }

  markNotification() async {
    log("marking..........");
    Response response = await APIRepo().markNotification(token: token);
    if (response.statusCode == 200) {
      loadNotification(token);
      log("notifications marked");
    }
  }

  approveUser(int userId) {
    notifyListeners();
  }

  setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  loadAccounts() async {
    Response response = await APIRepo().accounts();
    if (response.statusCode == 200) {
      _accounts = [];
      for (var item in response.data['data']) {
        AccountModel model = AccountModel.fromJson(item);
        model.side = model.role == 'user' ? 0 : 1;
        _accounts.add(model);
      }
      notifyListeners();
    } else {
      _accounts = [];
    }
  }

  loadTransfer(token) async {
    Response response = await APIRepo().transfers(token: token);
    if (response.statusCode == 200) {
      _transfers = [];
      for (var item in response.data['data']) {
        TransferModel model = TransferModel.fromJson(item);
        _transfers.add(model);
      }
      notifyListeners();
    } else {
      _transfers = [];
    }
  }

  loadNotification(token) async {
    Response response = await APIRepo().notifications(token: token);
    if (response.statusCode == 200) {
      _notifications = [];
      for (var item in response.data['data']) {
        NotificationModel model = NotificationModel.fromJson(item);
        _notifications.add(model);
      }
      notifyListeners();
    } else {
      _notifications = [];
    }
  }

  loadAdminFoodHistory(token) async {
    Response response = await APIRepo().adminFoodHistory(token: token);
    if (response.statusCode == 200) {
      _adminfoodHistory = [];
      for (var item in response.data['data']) {
        AdminFoodModel model = AdminFoodModel.fromJson(item);
        model.side = model.owner == model.actingUser!.id ? 0 : 1;
        print(model.side);

        _adminfoodHistory.add(model);
      }
      notifyListeners();
    } else {
      _transfers = [];
    }
  }

  loadAdminFoodTransfer(token) async {
    Response response = await APIRepo().adminTransferHistory(token: token);
    if (response.statusCode == 200) {
      _admintransferHistory = [];
      for (var item in response.data['data']) {
        AdminTransferModel model = AdminTransferModel.fromJson(item);
        _admintransferHistory.add(model);
      }
      notifyListeners();
    } else {
      _transfers = [];
    }
  }

  initLoading(String token, String type) {
    loadAccounts();

    if (type == 'user') {
      loadTransfer(token);
      loadNotification(token);
    } else {
      loadAdminFoodHistory(token);
      loadAdminFoodTransfer(token);
    }
  }

  login(context) async {
    bool isValid = _loginValidator(context);

    if (!isValid) {
      return;
    }

    Map<String, dynamic> payload = {"email": emailController.text, "password": passwordController.text};

    setLoading();

    Response response = await APIRepo().login(payload);

    if (response.statusCode == 200) {
      await AppStorage().updateToken(response.data['token'].toString());
      _accountModel = AccountModel.fromJson(response.data['data']);
      _token = response.data['token'].toString();
      _isLoading = false;
      initLoading(_token, _accountModel!.role!);
      notifyListeners();
      SocketService.instance.initialize(userId: _accountModel!.id.toString()); //initialize socket
      AppRoutes.irreversibleNavigate(context, const Dashboard());
    } else {
      _isLoading = false;
      notifyListeners();
      showToast(context, response.data['message']);
    }
  }

  register(context) async {
    bool isValid = _signupValidator(context);
    if (!isValid) {
      return;
    }

    Map<String, dynamic> payload = {"email": emailController.text, "password": passwordController.text, "name": formatNameFromEmail(emailController.text)};
    setLoading();

    Response response = await APIRepo().signup(payload);
    if (response.statusCode == 200) {
      await AppStorage().updateToken(response.data['token'].toString());
      _accountModel = AccountModel.fromJson(response.data['data']);
      _token = response.data['token'].toString();
      _isLoading = false;
      initLoading(_token, _accountModel!.role!);
      notifyListeners();
      SocketService.instance.initialize(userId: _accountModel!.id.toString()); //initialize socket
      AppRoutes.irreversibleNavigate(context, const Dashboard());
    } else {
      _isLoading = false;
      notifyListeners();
      showToast(context, response.data['message']);
    }
  }

  changepassword(context) async {
    bool isValid = _changepasswordValidator(context);

    if (!isValid) {
      return;
    }

    Map<String, dynamic> payload = {"oldPassword": oldPasswordController.text, "password": passwordController.text};

    print(payload);

    setLoading();

    Response response = await APIRepo().updateAccount(payload, token);

    if (response.statusCode == 200) {
      showToast(context, response.data['message']);
      setLoading();
    } else {
      showToast(context, response.data['message']);
      setLoading();
    }
  }

  Future<bool> validateAuthentication(context) async {
    var token = await AppStorage().readToken();

    if (token == "null") {
      AppRoutes.irreversibleNavigate(context, const LoginScreen());
      return false;
    }

    Response response = await APIRepo().refresh(token);

    if (response.statusCode == 200) {
      await AppStorage().updateToken(response.data['token'].toString());
      _accountModel = AccountModel.fromJson(response.data['data']);
      _token = response.data['token'].toString();
      notifyListeners();
      SocketService.instance.initialize(userId: _accountModel!.id.toString()); //initialize socket
      AppRoutes.irreversibleNavigate(context, const Dashboard());
    } else {
      print("response: $response");
      showToast(context, response.data['message']);
      AppRoutes.irreversibleNavigate(context, const LoginScreen());
      return false;
    }

    initLoading(_token, _accountModel!.role!);

    return true;
  }

  signout(context) async {
    AppRoutes.irreversibleNavigate(context, const LoginScreen());
    await AppStorage().clearToken();
    _accountModel = null;
  }

  _changepasswordValidator(context) {
    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty || oldPasswordController.text.isEmpty) {
      showToast(context, "All the fields are required");
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showToast(context, "Password and Confirm does not match");
      return false;
    }
    return true;
  }

  _loginValidator(context) {
    if (emailController.text.isEmpty) {
      showToast(context, "Email field cannot be empty");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showToast(context, "Password field cannot be empty");
      return false;
    }
    return true;
  }

  _signupValidator(context) {
    bool isValid = _loginValidator(context);

    if (!isValid) {
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showToast(context, "Passord does not match");
      return false;
    }

    return true;
  }
}
