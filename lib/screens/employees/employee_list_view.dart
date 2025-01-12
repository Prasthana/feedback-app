import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:notification_center/notification_center.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/employeesresponse.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/create_employee_view.dart';
import 'package:oneononetalks/screens/employees/employee_details_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/theme/theme_constants.dart' as themeconstants;
import 'package:oneononetalks/utils/notification_constants.dart'
    as notificationconstants;


class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  bool hasAccessToCreateEmployee = false;

  late Future<EmployeesResponse> employeesFuture ;

    
  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe(notificationconstants.updatingNewEmployee, onRefresh);
    checkCanCreateEmployee();
    employeesFuture = ApiManager.authenticated.fetchEmployeesList();
  }

  @override
  void dispose() {
    // Unsubscribe from the notification
    NotificationCenter().unsubscribe(notificationconstants.updatingNewEmployee);
    super.dispose();
  }

  FutureOr onRefresh(dynamic value) {
    Future<EmployeesResponse> refEmployeesFuture = ApiManager.authenticated.fetchEmployeesList();
    setState(() {
      employeesFuture = refEmployeesFuture;
    });
  }

  void setCanCreateEmployee(bool newValue) {
    setState(() {
      hasAccessToCreateEmployee = newValue;
    });
  }

  void checkCanCreateEmployee() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? tabCreate1On1Access =
            mPrepareCallResponse.user?.permissions?["employees.create"];
        if (tabCreate1On1Access?.access == Access.enabled) {
          setCanCreateEmployee(true);
        } else {
          setCanCreateEmployee(false);
        }
      } else {
        setCanCreateEmployee(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
      appBar: AppBar(title: const Text(constants.reportingTeamTitle)),
      body: Center(
        child: FutureBuilder<EmployeesResponse>(
          future: employeesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(backgroundColor: colorPrimary,valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
            } else if (snapshot.hasData) {
              final employeesResponse = snapshot.data;
              var listCount = employeesResponse?.employeesList?.length ?? 0;
              if (listCount > 0) {
                return buildEmployeesList(employeesResponse?.employeesList);
              } else {
                return buildEmptyListView();
              }
            } else {
              return buildEmptyListView();
            }
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: hasAccessToCreateEmployee,
        child: FloatingActionButton(
          onPressed: () {
            debugPrint('clickeed on calender ------>>>');
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEmployeeView(),));
            // used modal_bottom_sheet - to model present
            // showCupertinoModalBottomSheet(
            //   context: context,
            //   builder: (context) => CreateOneOnOneView(
            //     mEmployee: Employee(),
            //   ),
            //   enableDrag: true,
            // );
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }

 

  Widget buildEmployeesList(List<Employee>? employeeList) {
    return ListView.builder(
        itemCount: employeeList?.length,
        itemBuilder: (BuildContext context, int index) {
          var employee = employeeList?[index];

          return Column(
            children: <Widget>[
              ListTile(
                // leading:  TextDrawable(text: employee?.name ?? ""),
                leading: CircleAvatar(
                  backgroundColor: themeconstants.colorPrimary,
                  maxRadius: 28.0,
                  foregroundImage:  employee?.getAvatarImage(),
                  child: Text(
                    getInitials(employee?.name ?? "", 2),
                    style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  employee?.name ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(
                  employee?.designation ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),).then(onRefresh);
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
                constants.noEmployeeAdded,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(20),
              const Text(
                constants.addEmployeeMsg,
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
}
