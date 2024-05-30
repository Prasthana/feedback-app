import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/screens/home/mainhome_page.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:intl/intl.dart';

class OneonOneSuccessView extends StatefulWidget {
  OneonOneSuccessView({super.key, required this.oneOnOneResp});

  final OneOnOneCreateResponse oneOnOneResp;

  @override
  State<OneonOneSuccessView> createState() => _OneonOneSuccessViewState();
}

class _OneonOneSuccessViewState extends State<OneonOneSuccessView> {
  @override
  Widget build(BuildContext context) {
    var empName = widget.oneOnOneResp.oneOnOne.oneOnOneParticipants?.first.employee.name ?? "";
    var dateStr = widget.oneOnOneResp.oneOnOne.startDateTime ?? "";  
    var startDateTime = widget.oneOnOneResp.oneOnOne.startDateTime ?? "";
    var endDateTime = widget.oneOnOneResp.oneOnOne.endDateTime ?? "";
    String startTime = getFormatedTime(startDateTime);
    String endTime = getFormatedTime(endDateTime);

    var oneOn1Time = "$startTime - $endTime";
    String oneOn1Date = getFormatedDate(dateStr);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            multiFontText(empName, oneOn1Date, oneOn1Time),
            addVerticalSpace(40),
            const Text(
              constants.meetingSuccessDescriptionText,
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  // String getFormatedTime(String dateTimeString) {
  //     DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
  //     final DateFormat formatter = DateFormat.jm();
  //     return formatter.format(dateTime);
  // }
  // String getFormatedDate(String dateTimeString) {
  //     DateTime dateTime = DateTime.parse(dateTimeString).toUtc();
  //     return DateFormat('dd-MM-yyyy').format(dateTime);
  // }


  Padding meetingSuccessImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Image.asset(
          'assets/1-on-1_success.png',
        ) // Image.asset
        );
  }

  Widget multiFontText(String name, String date, String time) {
    return Column(
      children: [
                   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '1-on-1 with ',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  name,
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
                  date,
                  style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' at ',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  time,
                  style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' created',
                  style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
              ),
      ],
    );
  }
}
