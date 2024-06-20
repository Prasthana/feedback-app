import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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

    Timer(const Duration(milliseconds: 200), biometricAuthenticate);    
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
      if (e.message == constants.biometricNotEnable) {
        // ignore: use_build_context_synchronously
        showValidationAlert(context, constants.biometricNotEnableAlertText);
      }
      print("authenticate state ----->>>>${e.message}");
      return;
    }
    if (!mounted) {
       print("mounted ----->>>>");
      return;
    }

      setState(() {
        if (authenticated) {
              print("authenticate sucess ----->>>>");
              Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
              print("authenticate failed ----->>>>");
        }
      });
  }

    showValidationAlert(BuildContext context, String alertText) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(constants.okButton),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(constants.goToSettings),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [okButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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