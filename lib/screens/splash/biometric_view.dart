import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oneononetalks/screens/mainTab/maintab_view.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class BiometricView extends StatefulWidget {
  const BiometricView({super.key});

  @override
  State<BiometricView> createState() => _BiometricViewState();
}

class _BiometricViewState extends State<BiometricView> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), biometricAuthenticate);    
  }

  navigateToHomeScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainTabView(), fullscreenDialog: true));
  }

  Future<void> biometricAuthenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: constants.biometricHintText,
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print("authenticate state ----->>>>${e.message}");
      return;
    }
    if (!mounted) {
      return;
    }

      setState(() {
        if (authenticated) {
              print("authenticate sucess ----->>>>");
             Timer(const Duration(milliseconds: 5), navigateToHomeScreen);
        } else {
              print("authenticate failed ----->>>>");
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Center(
        child: TextButton(
            onPressed: () {
              print("faceID button -----");
              biometricAuthenticate();
            },
            child: Text(
              Platform.isIOS ? constants.faceIDUnlock : constants.biometricUnlock,
              style: const TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            )),
      ),
    );
  }
}