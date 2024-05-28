import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeesresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class SelectEmployeeView extends StatefulWidget {
  const SelectEmployeeView({super.key});

  @override
  State<SelectEmployeeView> createState() => _SelectEmployeeViewState();
}

class _SelectEmployeeViewState extends State<SelectEmployeeView> {
  Future<EmployeesResponse> employeesFuture =
      ApiManager.authenticated.fetchEmployeesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: colorText),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(constants.selectEmployeeText,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              )),
          backgroundColor: Colors.transparent,
        ),
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
        ));
  }

   String getInitials(String string, [int limitTo = 2]) {
    if (string == null || string.isEmpty) {
      return '';
    }

    var buffer = StringBuffer();
    var split = string.split(' ');

    //For one word
    if (split.length == 1) {
      return string.substring(0, 1);
    }

    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
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
                  backgroundColor: colorPrimary,
                  maxRadius: 28.0,
                  foregroundImage: NetworkImage(""),
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
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),);
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
