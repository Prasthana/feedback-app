import 'dart:convert';

import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/oneonone.dart';
import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/employees/employee_details_view.dart';
import 'package:feedbackapp/screens/oneOnOne/create_1on1_view.dart';
import 'package:feedbackapp/screens/oneOnOne/update_1on1_view.dart';
import 'package:feedbackapp/utils/date_formaters.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:feedbackapp/theme/theme_constants.dart' as themeconstants;
import 'package:network_logger/network_logger.dart';
import 'package:notification_center/notification_center.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:feedbackapp/utils/notification_constants.dart'
    as notificationconstants;

class UpcommingPageView extends StatefulWidget {
  const UpcommingPageView({super.key});

  @override
  State<UpcommingPageView> createState() => _UpcommingPageViewState();
}

class _UpcommingPageViewState extends State<UpcommingPageView> {
  // variable to call and store future list of posts
  String systemFormateDateTime = "";
  bool hasAccessToCreate1On1 = false;

  late Future<OneOnOnesResponse> oneOnOnesFuture;
  var loggedInUserId = LocalStorageManager.shared.loginUser?.id ?? 0;
  

  Future getSystemFormateDateTime() async {
    final datePattern = await SystemDateTimeFormat().getLongDatePattern();
    final timePattern = await SystemDateTimeFormat().getTimePattern();
    systemFormateDateTime = "$datePattern $timePattern";
    systemFormateDateTime;
  }

  @override
  void initState() {
    super.initState();
    showNetworkLogger(context);
    checkCanCreate1On1();
    getSystemFormateDateTime();
    oneOnOnesFuture = ApiManager.authenticated
        .fetchOneOnOnesList(constants.upcomingOneOnOnes);

    NotificationCenter()
        .subscribe(notificationconstants.oneOnOnesUpdated, reloadOneOnOnes);
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe(notificationconstants.oneOnOnesUpdated);
    super.dispose();
  }

  void reloadOneOnOnes(data) async {
    oneOnOnesFuture = ApiManager.authenticated
        .fetchOneOnOnesList(constants.upcomingOneOnOnes);

    setState(() {});
  }

  void setCanCreate1On1(bool newValue) {
    setState(() {
      hasAccessToCreate1On1 = newValue;
    });
  }

  void checkCanCreate1On1() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? tabCreate1On1Access =
            mPrepareCallResponse.user?.permissions?["one_on_ones.create"];
        if (tabCreate1On1Access?.access == Access.enabled) {
          setCanCreate1On1(true);
        } else {
          setCanCreate1On1(false);
        }
      } else {
        setCanCreate1On1(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<OneOnOnesResponse>(
          future: oneOnOnesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final oneOnOnesResponse = snapshot.data;
              var listCount = oneOnOnesResponse?.oneononesList?.length ?? 0;
              if (listCount > 0) {
                return buildoneOnOnesList(oneOnOnesResponse);
              } else {
                return buildEmptyListView();
              }
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: hasAccessToCreate1On1,
        child: FloatingActionButton(
          onPressed: () {
            debugPrint('clickeed on calender ------>>>');
            // used modal_bottom_sheet - to model present
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => CreateOneOnOneView(
                mEmployee: Employee(),
              ),
              enableDrag: true,
            );
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildoneOnOnesList(OneOnOnesResponse? oneOnOnesResponse) {
    return ListView.builder(
        itemCount: oneOnOnesResponse?.oneononesList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final oneOnOne = oneOnOnesResponse?.oneononesList?[index];
          String startTime = getFormatedDateConvertion(
              oneOnOne?.startDateTime ?? "", systemFormateDateTime);

          String employeeName =  oneOnOne?.getOpponentUser(loggedInUserId)?.name ?? "NA";

          debugPrint("---- employeeName ------>>> $employeeName");

          return Column(
            children: <Widget>[
              ListTile(
                // leading:  TextDrawable(text: employee?.name ?? ""),
                leading: CircleAvatar(
                  backgroundColor: themeconstants.colorPrimary,
                  maxRadius: 28.0,
                  foregroundImage: const NetworkImage(""),
                  child: Text(
                    getInitials(employeeName, 2),
                    style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  employeeName,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(
                  // DateFormat.yMMMMEEEEd().format(DateTime.now()),

                  startTime,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        UpdateOneoneOneView(oneOnOneData: oneOnOne),
                    enableDrag: true,
                  );
                },
              ),
              const Divider(
                color: Color.fromRGBO(195, 195, 195, 1),
                height: 3.0,
                thickness: 1.0,
                indent: 76.0,
                endIndent: 0,
              ),
            ],
          );
        });
  }

  Widget buildEmptyListView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/emptyOneOnOneList.png', height: 250),
              addVerticalSpace(20),
              const Text(
                'No 1-on-1 Meetings scheduled',
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(20),
              const Text(
                'You can create a 1-on-1 meeting by clicking on the calendar icon below.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }

  void navigateToMyProfile() {
    var sm = StorageManager();
    sm.getData(constants.loginTokenResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        logger.d('val -- $json');
        if (mLoginTokenResponse.user != null) {
          var employee = Employee();
          employee.id = mLoginTokenResponse.user?.employeeId ?? 0;
          employee.mobileNumber = mLoginTokenResponse.user?.mobileNumber ?? "";
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployeeDetailsView(mEmployee: employee)),
          );
        }
      }
    });
  }
}
