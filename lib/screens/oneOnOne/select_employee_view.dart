import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class SelectEmployeeView extends StatefulWidget {
  const SelectEmployeeView({super.key});

  @override
  State<SelectEmployeeView> createState() => _SelectEmployeeViewState();
}

class _SelectEmployeeViewState extends State<SelectEmployeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(constants.selectEmployeeText,
            style: TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
