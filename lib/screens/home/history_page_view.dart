
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/oneononesresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/employee_details_view.dart';
import 'package:oneononetalks/screens/oneOnOne/update_1on1_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/theme/theme_constants.dart' as themeconstants;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HistoryPageView extends StatefulWidget {
  const HistoryPageView({super.key});

  @override
  State<HistoryPageView> createState() => _HistoryPageViewState();
}


class _HistoryPageViewState extends State<HistoryPageView> {
  // variable to call and store future list of posts
  late String systemFormateDateTime;
  late Future<OneOnOnesResponse> oneOnOnesHistory;

  @override
  void initState() {
    super.initState();
    oneOnOnesHistory = ApiManager.authenticated.fetchOneOnOnesList(constants.historyOneOnOnes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<OneOnOnesResponse>(
          future: oneOnOnesHistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(backgroundColor: colorPrimary,valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
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

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     debugPrint('clickeed on calender ------>>>');
      // // used modal_bottom_sheet - to model present
      // showCupertinoModalBottomSheet(
      //   context: context,
      //   builder: (context) => CreateOneOnOneView(mEmployee: Employee(),),
      //   enableDrag: true,
      // );  
      //   },
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.calendar_month_outlined),
      // ),
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
        var employeeName = employee?.name ?? "Invalid Employee";

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
                title: Text(employeeName,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(
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
                      builder: (context) => UpdateOneoneOneView(oneOnOneData: oneOnOne),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employee)),);  
        } 
      } 
    });
  }
}
