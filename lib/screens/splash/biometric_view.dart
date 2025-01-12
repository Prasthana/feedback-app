import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/utils/helper_widgets.dart';

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
      if (e.message == constants.biometricNotEnable && Platform.isAndroid) {
        showValidationAlert(constants.biometricNotEnableAlertText);
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

    showValidationAlert(String alertText) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(constants.okButton),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [okButton],
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
    return PopScope(
      canPop: false,
      child: Scaffold(
         backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: Platform.isIOS ? 210 : 231,
            child: ElevatedButton(
                onPressed: () {
                  biometricAuthenticate();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Platform.isIOS ? constants.faceIDUnlock : constants.biometricUnlock,
                      style: const TextStyle(
                          fontFamily: constants.uberMoveFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    addHorizontalSpace(5),
                    const Icon(Icons.lock_open_outlined),
                  ],
                )
                ),
          ),
        ),
      ),
    );
  }
}