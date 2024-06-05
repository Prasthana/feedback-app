import 'dart:async';
import 'dart:convert';

import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/main.dart';
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
        Map<String, dynamic> json = jsonDecode(val);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        logger.d('val -- $json');

        // var refreshTokenStatus = await refreshLoginToken(mLoginTokenResponse.refreshToken ?? "");

       setLoginStatus(true);
        
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


  // Future<bool>  refreshLoginToken(String refreshToken) async {
  //   var request = LoginTokenRequest(
  //       grantType: constants.grantTypeRefreshToken,
  //       clientId: constants.clientId,
  //       clientSecret: constants.clientSecret,
  //       refreshToken: refreshToken);

  //   var success = await ApiManager.authenticated.generateLoginToken(request).then((val) {
  //     // do some operation
  //     logger.e('email response -- ${val.toJson()}');
  //     String user = jsonEncode(val.toJson());
  //     var sm = StorageManager();

  //     sm.saveData(constants.loginTokenResponse, user);

  //     sleep(const Duration(seconds: 1));

  //     return true;
  //   }).catchError((obj) {
  //     // non-200 error goes here.
  //     switch (obj.runtimeType) {
  //       case const (DioException):
  //         // Here's the sample to get the failed response error code and message
  //         final res = (obj as DioException).response;
  //         logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
  //         break;
  //       default:
  //         break;
  //     }
  //     return false;
  //   });
  //   return success;
  // }


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
