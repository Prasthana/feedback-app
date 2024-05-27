import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;

class CreateOneOnOneView extends StatelessWidget {
  const CreateOneOnOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "1-on-1",
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [addVerticalSpace(10.0), meetingImage(),
        const Text(constants.selectEmployeeText)
        ],
      ),
    );
  }

  Padding meetingImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54.0),
        child: Image.asset(
          'assets/meeting-image.png',
        ) // Image.asset
        );
  }
}
