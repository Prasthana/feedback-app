import 'dart:convert';

import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/employees/employee_details_view.dart';
import 'package:feedbackapp/screens/home/history_page_view.dart';
import 'package:feedbackapp/screens/home/upcoming_page_view.dart';
import 'package:feedbackapp/screens/oneOnOne/create_1on1_view.dart';
import 'package:feedbackapp/screens/oneOnOne/update_1on1_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:network_logger/network_logger.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:feedbackapp/theme/theme_constants.dart' as themeconstants;

class MainHomePageView extends StatefulWidget {
  const MainHomePageView({super.key});

  @override
  State<MainHomePageView> createState() => _MainHomePageViewState();
}

class _MainHomePageViewState extends State<MainHomePageView> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    NetworkLoggerOverlay.attachTo(context);
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() { });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // variable to call and store future list of posts
  // Future<OneOnOnesResponse> oneOnOnesFuture =
      // ApiManager.authenticated.fetchOneOnOnesList();

  // @override
  // void initState() {
  //   NetworkLoggerOverlay.attachTo(context);
  //   super.initState();
  // }

  TabBar get _tabBar => TabBar(
    controller: controller,
    indicatorColor: Colors.transparent,
          unselectedLabelStyle: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(111, 111, 111, 1),
                        ),
          labelStyle : const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        ),
  tabs: [
    _tab(constants.upcoming, isAllow: true),
    _tab(constants.history,),
  ],
);

Widget _tab(String text, {bool isAllow = false}) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: isAllow ? const Color.fromRGBO(1, 57, 98, 1): Colors.transparent, width: 1, style: BorderStyle.solid))) ,
      child: Tab(
        text: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(constants.oneOneOnScreenTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
                navigateToMyProfile();
              },
            )
          ],

          bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: ColoredBox(
            color: const Color.fromRGBO(0, 0, 0, 1),
            child: _tabBar,
          ),
        ), 
          ),

      body: TabBarView(
        controller: controller,
        children: const [
          UpcommingPageView(),
          HistoryPageView(),
        ],
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

        var employeeName = oneOnOne?.oneOnOneParticipants?.first.employee.name ?? "No Employee";

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
                title: Text(employeeName,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(

                  DateFormat.yMMMMEEEEd().format(DateTime.now()),

                  // oneOnOne?.scheduledDate?.toString() ?? "",
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
