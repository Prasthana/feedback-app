
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/one_on_one_create_request.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/oneOnOne/1on1_success_view.dart';
import 'package:oneononetalks/screens/oneOnOne/select_employee_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/snackbar_helper.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class CreateOneOnOneView extends StatefulWidget {
  final Employee? mEmployee;
  const CreateOneOnOneView({super.key, required this.mEmployee});

  @override
  State<CreateOneOnOneView> createState() => _CreateOneOnOneViewState();
}

class _CreateOneOnOneViewState extends State<CreateOneOnOneView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  String enteredNotes = "";
  Employee selectedEmployee = Employee();
  bool isEmployeeEdite = true;
  Employee employee = Employee();
  bool isEmployee = false;

  //String _selectedOption = constants.doesNotRepeatText;

  @override
  void initState() {
    super.initState();
    checkEmployeeOrManager();
    selectedEmployee = widget.mEmployee!;
    if (selectedEmployee.id != null) {
      isEmployeeEdite = false;
    }
    _updateTime();
  }

  void _updateTime() {
    final now = TimeOfDay.now();
    final newTime = addOneHour(now);
    setState(() {
      selectedEndTime = newTime;
    });
  }

  void setEmployee(bool newValue) {
    setState(() {
      isEmployee= newValue;
    });
  }

  void checkEmployeeOrManager() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? teamTabAccess =mPrepareCallResponse.user?.permissions?["teams.tab"];
        employee = mPrepareCallResponse.user?.employee as Employee;
        if (teamTabAccess?.access == Access.enabled) {
          setEmployee(false);
        } else {
          setEmployee(true);
        }
      } else {
        setEmployee(true);
      }
    });
  }

/*
  final List<String> _options = [
    "Does not repeat",
    "Daily",
    "Weekly on friday",
    "custom"
  ];


  void _showRadioButtonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tempSelectedOption = _selectedOption;
        return CupertinoAlertDialog(
          content: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: _options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: tempSelectedOption,
                  onChanged: (value) {
                    setState(() {
                      tempSelectedOption = value!;
                    });
                  },
                );
              }).toList(),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                setState(() {
                  _selectedOption = tempSelectedOption;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

*/

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

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedTime;
          selectedEndTime = addOneHour(pickedTime);
        } else {
          selectedEndTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          constants.oneOnOneText,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(10.0),
              meetingImage(),
              Row(
                children: [
                  Text(
                    !isEmployee ? constants.selectEmployeeText : constants.yourmanagerText,
                    style:  const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  const Text(
                    '*',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              addVerticalSpace(8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 51.0,
                child: TextButton(
                  onPressed: !isEmployee ? () async {
                    selectEmployee();
                  } : null,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: const BorderSide(color: colorText, width: 1.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      !isEmployee ? 
                          (selectedEmployee.name != null)
                            ? showEmployeeAvatar()
                            : const Text('') : showEmployeeAvatar(),
                        addHorizontalSpace(5), 
                        Text(
                          !isEmployee ?
                          selectedEmployee.name != null
                              ? selectedEmployee.name ?? ""
                              : constants.searchEmployeeText : employee.manager?.name ?? "",
                          style: const TextStyle(
                            color: colorText,
                            fontFamily: constants.uberMoveFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              addVerticalSpace(20),
              showDatePickar(),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showTimePickar(true),
                  addHorizontalSpace(24),
                  showTimePickar(false),
                ],
              ),
              /*
              addVerticalSpace(18),
              GestureDetector(
                onTap: () {
                  debugPrint('GestureDetector ------->>>>');
                  _showRadioButtonDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      constants.repeatText,
                      style: TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    addHorizontalSpace(10),
                    Text(
                      _selectedOption,
                      style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    addHorizontalSpace(5),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            */
              addVerticalSpace(20),
              const Text(
                constants.notesText,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(8),
              TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: constants.notesHintText,
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(111, 111, 111, 1), fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorText,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    enteredNotes = value;
                  }),
              addVerticalSpace(20),
              MaterialButton(
                minWidth: double.infinity,
                height: 58.0,
                onPressed: () {
                  debugPrint("clicked on create ----->>>>");
                  if (selectedEmployee.name == null && !isEmployee) {
                    displaySnackbar(
                        context, constants.selectEmployeeValidationText);
                  } else {
                    showLoader(context);
                    var utcStartTime = toUtcDateTime(selectedStartTime).toUtc();
                    var utcEndTime = toUtcDateTime(selectedEndTime).toUtc();

                    var onlyStartTime = getTimeFromUtcDateTime(utcStartTime);
                    var onlyEndTime = getTimeFromUtcDateTime(utcEndTime);
                    var dateStr = DateFormat(yearMonthDate).format(selectedDate);
                    var startDateTimeStr = "$dateStr $onlyStartTime";
                    var utcStartDateTime = startDateTimeStr.utcDateObj("$yearMonthDate $hoursMinutes24");
         
                    var endDateTimeStr = "$dateStr $onlyEndTime";
                    var utcEndDateTime = endDateTimeStr.utcDateObj("$yearMonthDate $hoursMinutes24");
                        
                    _createOneOnOneRequest(
                        utcStartDateTime.toString(),
                        utcEndDateTime.toString(),
                        enteredNotes,
                        !isEmployee ? selectedEmployee.id ?? 0 : employee.manager?.id ?? 0,
                        context);
                  }
                },
                // ignore: sort_child_properties_last
                child: const Text(constants.createText),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: const Color.fromRGBO(0, 0, 0, 1),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showDatePickar() {
    return Column(
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
          width: (MediaQuery.of(context).size.width),
          height: 51.0,
          child: TextButton(
            onPressed: () {
              _selectDate(context);
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: const BorderSide(color: colorText, width: 1.0),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat(dateMonthYear).format(selectedDate),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: colorText,
                  fontFamily: constants.uberMoveFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget showTimePickar(bool isStarTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isStarTime ? constants.startTimeText : constants.endTimeText,
          style: const TextStyle(
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
              _selectTime(isStarTime);
              // showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: const BorderSide(color: colorText, width: 1.0),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                formatTimeOfDay(
                    isStarTime ? selectedStartTime : selectedEndTime),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: colorText,
                  fontFamily: constants.uberMoveFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget showEmployeeAvatar() {
    return CircleAvatar(
      backgroundColor: colorPrimary,
      maxRadius: 18.0,
      foregroundImage: isEmployee ? employee.manager?.getAvatarImage()  : selectedEmployee.getAvatarImage(), 
      child: Text(
        getInitials(!isEmployee ? selectedEmployee.name ?? "" : employee.manager?.name ?? "", 2),
        style: const TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );
  }

  Padding meetingImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54.0),
        child: Image.asset(
          'assets/emptyOneOnOneList.png',
        ) // Image.asset
        );
  }

  _createOneOnOneRequest(String startDateTime, String endDateTime, String notes,
      int employeeId, BuildContext context) async {
    List<OneOnOneParticipantsAttribute> oneOnOneAttributes = [];
    var attr = OneOnOneParticipantsAttribute(employeeId: employeeId);
    oneOnOneAttributes.add(attr);

    var oneOnOneObj = OneOnOne(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        notes: notes,
        oneOnOneParticipantsAttributes: oneOnOneAttributes);

    var request = OneOnOneCreateRequest(oneOnOne: oneOnOneObj);
    ApiManager.authenticated.createOneOnOne(request).then((val) {
      hideLoader();
      logger.e('createOneOnOne response -- ${val.toJson()}');
      Navigator.pop(context);
      showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => OneonOneSuccessView(oneOnOneResp: val),
        enableDrag: true,
      );
    }).catchError((obj) {
      hideLoader();
      switch (obj.runtimeType) {
        case const (DioException):
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioException).response;
          logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');

          break;
        default:
          break;
      }
    });
  }

  void selectEmployee() async {
    if (isEmployeeEdite == true) {
      final result = await showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => const SelectEmployeeView(),
      );
      setState(() {
        if (result != null) {
          selectedEmployee = result as Employee;
          }
        });
        logger.e("result - ${selectedEmployee.name}");
    }
  }
}
