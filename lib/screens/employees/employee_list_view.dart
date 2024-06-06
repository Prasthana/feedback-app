import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeesresponse.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/employees/create_employee_view.dart';
import 'package:feedbackapp/screens/employees/employee_details_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:feedbackapp/theme/theme_constants.dart' as themeconstants;

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  bool hasAccessToCreateEmployee = false;

  Future<EmployeesResponse> employeesFuture =
      ApiManager.authenticated.fetchEmployeesList();

  @override
  void initState() {
    super.initState();
    checkCanCreateEmployee();
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
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(constants.reportingTeamTitle)),
      body: Center(
        child: FutureBuilder<EmployeesResponse>(
          future: employeesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEployeeView(),));
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
                  foregroundImage: CachedNetworkImageProvider(employee?.avatarAttachmentUrl ?? ""),
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
