import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/oneononesresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/employee_details_view.dart';
import 'package:oneononetalks/screens/home/history_page_view.dart';
import 'package:oneononetalks/screens/home/upcoming_page_view.dart';
import 'package:oneononetalks/screens/oneOnOne/update_1on1_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/theme/theme_constants.dart' as themeconstants;

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
    showNetworkLogger(context);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(constants.oneOneOnScreenTitle),
          backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              iconSize: 32.0,
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
    );
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employee)),);  
        } 
      } 
    });
  }
}
