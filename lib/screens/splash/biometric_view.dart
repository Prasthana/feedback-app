

import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class BiometricView extends StatefulWidget {
  const BiometricView({super.key});

  @override
  State<BiometricView> createState() => _BiometricViewState();
}

class _BiometricViewState extends State<BiometricView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {
          print("faceID button -----");
        }
        , child:  const Text('Use faceID', style: TextStyle(
          fontFamily: constants.uberMoveFont,
          fontSize: 14,
          fontWeight: FontWeight.w700
        ),)),
      ),
    );
  }
}