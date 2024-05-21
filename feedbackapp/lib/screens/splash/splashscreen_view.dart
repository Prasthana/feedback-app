import 'dart:async';

import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/mainTab/maintab_view.dart';
import 'package:flutter/foundation.dart';
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

  @override
  void initState() {
    super.initState();
      /*

    StorageManager().saveData("A", "B");
    if (kDebugMode) {
      print('Key A value is');
      print(StorageManager().getData('A'));
    }
    */

    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLoggedIn() ? const MainTabView() : const LoginView(),
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
