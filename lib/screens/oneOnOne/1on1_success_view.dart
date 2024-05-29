import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

// class OneonOneSuccessView extends StatefulWidget {
//   OneonOneSuccessView({super.key, required this.oneOnOneResp});

//   final OneOnOneCreateResponse oneOnOneResp;

//   @override
//   State<OneonOneSuccessView> createState() => _OneonOneSuccessViewState();
// }

class OneonOneSuccessView extends StatefulWidget {
  const OneonOneSuccessView({super.key, required this.oneOnOneResp});

  final String oneOnOneResp;
  @override
  State<OneonOneSuccessView> createState() => _OneonOneSuccessViewState();
}

class _OneonOneSuccessViewState extends State<OneonOneSuccessView> {
  @override
  Widget build(BuildContext context) {
    var oName = "Raju Kamatham"; //widget.oneOnOneResp;
    var oDate = "18-05-24"; // widget.oneOnOneResp;
    var oTime = "9:45 -11:45"; //widget.oneOnOneResp;

    // widget.oneOnOneResp.oneOnOne.startDateTime;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(90),
            meetingSuccessImage(),
            addVerticalSpace(60),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '1-on-1 with ',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  oName,
                  style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' for',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                  oDate,
                  style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' at ',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  oTime,
                  style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' created',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
              ),
            addVerticalSpace(20),
            const Text(
              "We have sent an email to your employee regarding the 1-on-1 meeting. Wishing you a productive meeting!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            addVerticalSpace(90),
            MaterialButton(
              minWidth: double.infinity,
              height: 58.0,
              onPressed: () {},
              // ignore: sort_child_properties_last
              child: const Text(
                "Done",
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: colorText,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Padding meetingSuccessImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Image.asset(
          'assets/1-on-1_success.png',
        ) // Image.asset
        );
  }
}
