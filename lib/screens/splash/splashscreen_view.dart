import 'dart:async';
import 'dart:convert';

import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/login/environment_setting_view.dart';
import 'package:oneononetalks/screens/login/login_view.dart';
import 'package:oneononetalks/screens/mainTab/maintab_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  var isLogedIn = false;
  var sm = StorageManager();

  void setLoginStatus(bool newValue) {
    setState(() {
      isLogedIn = newValue;
    });
    navigateToAppScreen();
  }

  checkLoginstatus() {
    sm.getData(constants.loginTokenResponse).then((val) async {
      if (val != constants.noDataFound) {
        try {
          Map<String, dynamic> json = jsonDecode(val);
          var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
          LocalStorageManager.shared.loginUser = mLoginTokenResponse.user;
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

  getCurrentEnvironment() {
        sm.getData(constants.environmentId).then((val) async {
      if (val != constants.noDataFound) {
        var envId = int.parse(val);
       // print("get selected EnvId -------->>>>24a> $envId");

        Environment env = EnvironmentManager.environments.firstWhere((item) => item.id == envId);
        if (env.name == constants.stagingText) {
          EnvironmentManager.isProdEnv = false;
        } else {
          EnvironmentManager.isProdEnv = true;
        }
        EnvironmentManager.currentEnv = env;
      }
    });
  }

  setDefaultEnvironmentAsProuduction(bool isProduction) {
    if (isProduction) {
      Environment proudEnv = EnvironmentManager.environments.last;
      sm.saveData(constants.environmentId, proudEnv.id.toString());
    } else {
      Environment devEnv = EnvironmentManager.environments.first;
      sm.saveData(constants.environmentId, devEnv.id.toString());
    }
     
  }

  @override
  void initState() {
    super.initState();
    checkLoginstatus();
    setDefaultEnvironmentAsProuduction(true);
    Timer(const Duration(seconds: 1), getCurrentEnvironment);  
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      feedbackLogo(),
      addVerticalSpace(30),
      // Add some space between the image and loader
      const CircularProgressIndicator(backgroundColor: colorPrimary,valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
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
                fullscreenDialog: true)));
  }
}
