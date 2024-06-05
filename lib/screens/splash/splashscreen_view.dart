import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/mainTab/maintab_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  var isLogedIn = false;

  void setLoginStatus(bool newValue) {
    setState(() {
      isLogedIn = newValue;
    });
    navigateToAppScreen();
  }

  checkLoginstatus() {
    var sm = StorageManager();
    sm.getData(constants.loginTokenResponse).then((val) async {
      if (val != constants.noDataFound) {
        try {
          logger.d('val -- $json');
          setLoginStatus(true);
        } catch (e) {
          logger.e("Exception is $e");
          setLoginStatus(false);
        }
      } else {
        setLoginStatus(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginstatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      feedbackLogo(),
      addVerticalSpace(30),
      // Add some space between the image and loader
      const CircularProgressIndicator()
    ]);
  }

  Padding feedbackLogo() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Image.asset(
          'assets/splash-image.png',
        ) // Image.asset
        );
  }


  navigateToAppScreen() {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLogedIn ? const MainTabView() : const LoginView(),
                //LoginView(),
                fullscreenDialog: true)));
  }
}
