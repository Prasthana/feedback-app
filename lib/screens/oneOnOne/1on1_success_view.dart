import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class OneonOneSuccessView extends StatefulWidget {
  OneonOneSuccessView({super.key, required this.oneOnOneResp});

  OneOnOneCreateResponse oneOnOneResp;
  @override
  State<OneonOneSuccessView> createState() => _OneonOneSuccessViewState();
}

class _OneonOneSuccessViewState extends State<OneonOneSuccessView> {
  
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
        title: const Text(
         // widget.oneOnOneResp.oneOnOne.
          "1-on-1",
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
