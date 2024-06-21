import 'package:oneononetalks/api_services/models/one_on_one_create_response.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:notification_center/notification_center.dart';
import 'package:oneononetalks/utils/notification_constants.dart' as notificationconstants;

class OneonOneSuccessView extends StatefulWidget {
  const OneonOneSuccessView({super.key, required this.oneOnOneResp});

  final OneOnOneCreateResponse oneOnOneResp;

  @override
  State<OneonOneSuccessView> createState() => _OneonOneSuccessViewState();
}

class _OneonOneSuccessViewState extends State<OneonOneSuccessView> {
   
  @override
  void dispose() {
    super.dispose();
    NotificationCenter().notify(notificationconstants.oneOnOnesUpdated);
  }

  @override
  Widget build(BuildContext context) {
    var empName = widget.oneOnOneResp.oneOnOne.getOpponentUser()?.name ?? "";
    var dateStr = widget.oneOnOneResp.oneOnOne.startDateTime;  
    var startDateTime = widget.oneOnOneResp.oneOnOne.startDateTime;
    var endDateTime = widget.oneOnOneResp.oneOnOne.endDateTime;
    String startTime = startDateTime.toString().utcToLocalDate(hoursMinutes12);
    String endTime = endDateTime.toString().utcToLocalDate(hoursMinutes12);
 
    var oneOn1Time = "$startTime - $endTime";
    String oneOn1Date = getFormatedDateConvertion(dateStr ?? "", dateMonthYear);
  
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(90),
            meetingSuccessImage(),
            addVerticalSpace(60),
            multiFontText(empName, oneOn1Date, oneOn1Time),
            addVerticalSpace(20),
            const Text(
              constants.meetingSuccessDescriptionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            addVerticalSpace(30),
            MaterialButton(
              minWidth: double.infinity,
              height: 58.0,
              onPressed: () {
                NotificationCenter().notify(notificationconstants.oneOnOnesUpdated);

                Navigator.pop(context);
              },
              // ignore: sort_child_properties_last
              child: const Text(
                constants.doneButtonText,
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
        )
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

  Widget multiFontText(String name, String date, String time) {
    return  Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0),
    child : Column(
      children: [
         Wrap(
          alignment: WrapAlignment.center,
          children: [              
            const Text(
              constants.oneOnOneWithText,
              style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                name,
                style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Text(
                constants.forText,
                style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                date,
                style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Text(
                constants.atText,
                style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                time,
                style: const TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Text(
                constants.createdText,
                style: TextStyle(fontFamily: constants.uberMoveFont, fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
      ],
    ),
    );
  }
}
