import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promeal/config/data.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/model/account.model.dart';
import 'package:promeal/screen/dashboard.screen.dart';
import 'package:promeal/services/api.repo.dart';
import 'package:promeal/storage/local.storage.dart';

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
    Map<String, dynamic> payload = {"email": emailController.text, "password": passwordController.text};

    setLoading();

    Response response = await APIRepo().login(payload);

    await AppStorage().updateToken(response.data['token'].toString());

    // log(response.data['token'].toString());

    _accountModel = AccountModel.fromJson(response.data['data']);

    _isLoading = false;

    notifyListeners();

    AppRoutes.irreversibleNavigate(context, const Dashboard());
  }


    register(context) async {
    Map<String, dynamic> payload = {"email": emailController.text, "password": passwordController.text};

    setLoading();

    Response response = await APIRepo().login(payload);

    await AppStorage().updateToken(response.data['token'].toString());

    // log(response.data['token'].toString());

    _accountModel = AccountModel.fromJson(response.data['data']);

    _isLoading = false;

    notifyListeners();

    AppRoutes.irreversibleNavigate(context, const Dashboard());
  }
}
