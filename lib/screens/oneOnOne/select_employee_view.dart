import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/employeesresponse.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/utils/utilities.dart';

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
          backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
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
        ),
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
        ));
  }

  Widget buildEmployeesList(List<Employee>? employeeList) {
    return ListView.builder(
        itemCount: employeeList?.length,
        itemBuilder: (BuildContext context, int index) {
          var employee = employeeList?[index];

          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorPrimary,
                  maxRadius: 28.0,
                  foregroundImage: employee?.getAvatarImage(),
                  child: Text(
                    getInitials(employee?.name ?? "", 2),
                    style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
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
                  var mEmployee = employeeList![index];
                  Navigator.pop(context, mEmployee);
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView()),);
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
