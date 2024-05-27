import 'package:feedbackapp/constants.dart';
import 'package:feedbackapp/screens/oneOnOne/select_employee_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class CreateOneOnOneView extends StatefulWidget {
  const CreateOneOnOneView({super.key});

@override
  State<CreateOneOnOneView> createState() => _CreateOneOnOneViewState();
}

class _CreateOneOnOneViewState extends State<CreateOneOnOneView> {

 DateTime selectedDate = DateTime.now();
 TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

    Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Optional initial time to display
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

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
                  showCupertinoModalBottomSheet(
                    context: context,
                     builder: (context) => const SelectEmployeeView(),
                  );

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
            addVerticalSpace(26),

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
                          _selectDate(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: const BorderSide(color: textColor, width: 1.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(selectedDate),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
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
                          _selectTime();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: const BorderSide(color: textColor, width: 1.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedTime.hour.toString() + " : " + selectedTime.minute.toString(),
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
