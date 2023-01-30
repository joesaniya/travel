import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/user.dart';

class ProfileController extends FxController {
  bool showLoading = true, uiLoading = true;
  bool notification = true, offlineReading = false;
  late User user;

  @override
  initState() {
    super.initState();

    fetchData();
    fetchloader();
  }

  void fetchloader() async {
    await Future.delayed(const Duration(seconds: 4));

    uiLoading = false;
    log('fetchloader');
    log(uiLoading.toString());
    update();
  }

  void fetchData() async {
    user = await User.getOne();
    await Future.delayed(const Duration(seconds: 1));

    // showLoading = false;
    // uiLoading = false;
    update();
  }

  void logout() {
    Navigator.pop(context);
  }

  @override
  String getTag() {
    return "profile_controller";
  }
}
