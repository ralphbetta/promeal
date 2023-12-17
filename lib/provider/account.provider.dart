import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/model/account.model.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/screen/authscreen/auth.screen.dart';
import 'package:promeal/screen/dashboard.screen.dart';
import 'package:promeal/services/api.service.dart';
import 'package:promeal/services/socket.service.dart';
import 'package:promeal/storage/local.storage.dart';
import 'package:promeal/utils/toast.utils.dart';

class AccountProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AccountModel? _accountModel;
  AccountModel? get accountModel => _accountModel;

  setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
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
      _isLoading = false;
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
    Map<String, dynamic> payload = {"email": emailController.text, "password": passwordController.text};
    setLoading();

    Response response = await APIRepo().signup(payload);
    if (response.statusCode == 200) {
      await AppStorage().updateToken(response.data['token'].toString());
      _accountModel = AccountModel.fromJson(response.data['data']);
      _isLoading = false;
      notifyListeners();
      SocketService.instance.initialize(userId: _accountModel!.id.toString()); //initialize socket
      AppRoutes.irreversibleNavigate(context, const Dashboard());
    } else {
      _isLoading = false;
      notifyListeners();
      showToast(context, response.data['message']);
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
      notifyListeners();
      SocketService.instance.initialize(userId: _accountModel!.id.toString()); //initialize socket
      AppRoutes.irreversibleNavigate(context, const Dashboard());
    } else {
      showToast(context, response.data['message']);
      AppRoutes.irreversibleNavigate(context, const LoginScreen());
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
