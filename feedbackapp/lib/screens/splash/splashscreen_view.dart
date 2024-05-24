import 'dart:async';

import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/mainTab/maintab_view.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  bool isLoggedIn() {
    return true;
  }

  saveTempToken() {
    var sm = StorageManager();

    sm.saveData('TOKEN',
        'eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJmZWVkYmFjay1hcGkiLCJpYXQiOjE3MTY1NDg2MTcsImp0aSI6Ijg3ZWVjOTQxLTNkZWUtNDQyYy05NDM3LTNmODIxYzhmMzEzMiJ9.575n34BbSKO75S4ZbYUgB7ucnKbrMhCtewx3k1ke6m4JR7D4T3OhNLJ3ZQvdde6sx3zivWDaXKITazkH2IAVQA');
    logger.d('Key A value is');
    // print(
    sm.getData('A').then((val) {
      // do some operation
      logger.d('val -- $val');
    });
  }

  @override
  void initState() {
    super.initState();

    saveTempToken();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLoggedIn() ? const MainTabView() : const LoginView(),
                //LoginView(),
                fullscreenDialog: true)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      feedbackLogo(),
      const SizedBox(height: 30),
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
}
