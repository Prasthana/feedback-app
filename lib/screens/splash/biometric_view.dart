import 'dart:async';

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
  _SupportState supportState = _SupportState.unknown;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), checkAuthenticate);    
  }

  navigateToHomeScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainTabView(), fullscreenDialog: true));
  }

  Future<void> checkAuthenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
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
             Timer(const Duration(seconds: 1), navigateToHomeScreen);
        } else {
              print("authenticate failed ----->>>>");
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              print("faceID button -----");
              checkAuthenticate();
            },
            child: const Text(
              'Use faceID',
              style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            )),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
