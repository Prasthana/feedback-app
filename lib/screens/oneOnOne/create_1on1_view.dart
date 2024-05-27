import 'package:feedbackapp/constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;
import 'package:flutter/widgets.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(10.0),
            meetingImage(),
            const Text(
              constants.selectEmployeeText,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            addVerticalSpace(8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 51.0,
              child: TextButton(
                onPressed: () {
                  debugPrint("search employee ------>>>>");
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(color: textColor, width: 1.0),
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    constants.searchEmployeeText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: constants.uberMoveFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            addVerticalSpace(36),

            /// *************Date start***************
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      constants.dateText,
                      style: TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    addVerticalSpace(8),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 28,
                      height: 51.0,
                      child: TextButton(
                        onPressed: () {
                          debugPrint("select date ------>>>>");
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: const BorderSide(color: textColor, width: 1.0),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "27/05/2024",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: constants.uberMoveFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // *************Date end***************
                addHorizontalSpace(24),
                // *************Time start***************
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      constants.timeText,
                      style: TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    addVerticalSpace(8),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 28,
                      height: 51.0,
                      child: TextButton(
                        onPressed: () {
                          debugPrint("select time ------>>>>");
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: const BorderSide(color: textColor, width: 1.0),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "9:45 AM - 10:45 AM",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: constants.uberMoveFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ), // *************Time end***************
          ],
        ),
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
