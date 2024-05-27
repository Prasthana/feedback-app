

import 'package:feedbackapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;

class SelectEmployeeView
 extends StatelessWidget {
  const SelectEmployeeView
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(constants.selectEmployeeText),
        backgroundColor: Colors.amber,
      ),
    );
  }


}