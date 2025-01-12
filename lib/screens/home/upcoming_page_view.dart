import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/oneononesresponse.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/employee_details_view.dart';
import 'package:oneononetalks/screens/oneOnOne/create_1on1_view.dart';
import 'package:oneononetalks/screens/oneOnOne/update_1on1_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/theme/theme_constants.dart' as themeconstants;
import 'package:notification_center/notification_center.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:oneononetalks/utils/notification_constants.dart'
    as notificationconstants;

class UpcommingPageView extends StatefulWidget {
  const UpcommingPageView({super.key});

  @override
  State<UpcommingPageView> createState() => _UpcommingPageViewState();
}

class _UpcommingPageViewState extends State<UpcommingPageView> {
  // variable to call and store future list of posts
  bool hasAccessToCreate1On1 = false;

  late Future<OneOnOnesResponse> oneOnOnesFuture;
  
  @override
  void initState() {
    super.initState();
    showNetworkLogger(context);
    checkCanCreate1On1();
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
              return const CircularProgressIndicator(backgroundColor: colorPrimary, valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
            } else if (snapshot.hasData) {
              final oneOnOnesResponse = snapshot.data;
              var listCount = oneOnOnesResponse?.oneononesList?.length ?? 0;
              if (listCount > 0) {
                return buildoneOnOnesList(oneOnOnesResponse);
              } else {
                return buildEmptyListView();
              }
            } else {
              return const Text(constants.noDataAvailable);
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
          var startDateTime = oneOnOne?.startDateTime ?? "";
          String startTime = startDateTime.utcToLocalDate(fullDateWithDayName);
          Employee? employee = oneOnOne?.getOpponentUser();
          String employeeName =  employee?.name ?? constants.invalidEmployee;

          debugPrint("---- employeeName ------>>> $employeeName");

          return Column(
            children: <Widget>[
              ListTile(
                // leading:  TextDrawable(text: employee?.name ?? ""),
                leading: CircleAvatar(
                  backgroundColor: themeconstants.colorPrimary,
                  maxRadius: 28.0,
                  foregroundImage: employee?.getAvatarImage(),
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
                constants.noOneOnOneScheduled,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(20),
              const Text(
                constants.clickOnCalendarText,
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
