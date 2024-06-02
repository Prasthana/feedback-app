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
  }

  checkLoginstatus() {
    var sm = StorageManager();
    sm.getData(constants.loginTokenResponse).then((val) async {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        logger.d('val -- $json');

      var refreshTokenStatus = await refreshLoginToken(mLoginTokenResponse.refreshToken ?? "");

          if (refreshTokenStatus == true) {
            setLoginStatus(true);
          } else {
            setLoginStatus(false);
          }
        
      } else {
        setLoginStatus(false);
      }
    });
  }

/*
  saveTempToken() {
    var sm = StorageManager();
    sm.saveData('TOKEN',
        'eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJmZWVkYmFjay1hcGkiLCJpYXQiOjE3MTY1NTQyMTUsImp0aSI6Ijc1MDU1ODhiLTRkNjYtNDMzMi04NTE0LTJiOTk1OTBlYTEzZSJ9.pBvXYMgj6y7TbSwQOYL3-XjMGtseLhgGywjZ9hXWugmhMEx4EpWAwIn8SIQd2OeI8RhQS_nBSY5m2VTwcS4j4g');
    logger.d('Key A value is');
    // print(
    sm.getData('A').then((val) {
      // do some operation
      logger.d('val -- $val');
    });
  }
  */

  @override
  void initState() {
    super.initState();

    checkLoginstatus();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLogedIn ? const MainTabView() : const LoginView(),
                //LoginView(),
                fullscreenDialog: true)));
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

  Future<bool>  refreshLoginToken(String refreshToken) async {
    var request = LoginTokenRequest(
        grantType: constants.grantTypeRefreshToken,
        clientId: constants.clientId,
        clientSecret: constants.clientSecret,
        refreshToken: refreshToken);

    var success = await ApiManager.public.generateLoginToken(request).then((val) {
      // do some operation
      logger.e('email response -- ${val.toJson()}');
      String user = jsonEncode(val.toJson());
      var sm = StorageManager();

      sm.saveData(constants.loginTokenResponse, user);

      sleep(const Duration(seconds: 1));

      return true;
    }).catchError((obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case const (DioException):
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioException).response;
          logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
          break;
        default:
          break;
      }
      return false;
    });
    return success;
  }
}
