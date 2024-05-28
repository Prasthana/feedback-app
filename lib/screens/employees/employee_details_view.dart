
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeedetailsresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:feedbackapp/theme/theme_constants.dart' as themeconstants;

class EmployeeDetailsView extends StatefulWidget {
  EmployeeDetailsView({super.key, required this.mEmployee});

  Employee mEmployee;

  @override
  State<EmployeeDetailsView> createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
 Future<EmployeeDetailsResponse>? employeeFuture;

  @override
  void initState() {
    this.employeeFuture = ApiManager.authenticated.fetchEmployeesDetails(widget.mEmployee!.id);
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white ,
        title: Text(widget.mEmployee.name ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
              child: FutureBuilder<EmployeeDetailsResponse>(
                future: employeeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final employeeResponse = snapshot.data;
                    if (employeeResponse?.employee != null) {
                      return buildEmployeeDetailsView(employeeResponse?.employee);
                    } else {
                      return buildEmployeeDetailsView(widget.mEmployee);
                    }
                  } else {
                    return buildEmployeeDetailsView(widget.mEmployee);
                  }
                },
              ),
            ),
    
    );
  }

  Widget buildEmployeeDetailsView(Employee? employee) {
    return  Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(12),
               Center(
                child: CircleAvatar(
                  backgroundColor: themeconstants.colorPrimary,
                  maxRadius: 64.0,
                  foregroundImage: NetworkImage(""),
                  child: Text(
                    getInitials(widget.mEmployee.name ?? "", 2),
                    style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ),
              
              addVerticalSpace(12),

              Center(
                child: Text(
                  widget.mEmployee.name ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              ),

              addVerticalSpace(8),

              Center(
                child: Text(
                  widget.mEmployee.designation ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              ),

              addVerticalSpace(8),

              Center(
                child: Text(
                  widget.mEmployee.email ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              ),

              addVerticalSpace(8),

              const Center(
                child: Text(
                  widget.mEmployee.email ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(22, 97, 210, 1)),
                ),
              ),

              addVerticalSpace(24),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
                  child: const Text(
                  constants.settings,
                  style: TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
                ),
              ),

            addVerticalSpace(6),

            ListTile(
                leading: Image.asset('assets/icApplock.png', height: 38),
                trailing: const Icon(Icons.chevron_right),
                title: const Text(
                 constants.appLock,
                  style: TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
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
                indent: 68.0,
                endIndent: 0,
              ),

              ListTile(
                leading: Image.asset('assets/icLogout.png', height: 38),
                trailing: const Icon(Icons.chevron_right),
                title: const Text(
                 constants.logOut,
                  style: TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
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
                indent: 68.0,
                endIndent: 0,
              ),

            ],
        )
      );
  }

  String getInitials(String string, [int limitTo = 2]) {
    if (string.isEmpty) {
      return '';
    }

    var buffer = StringBuffer();
    var split = string.split(' ');

    //For one word
    if (split.length == 1) {
      return string.substring(0, 1);
    }

    for (var i = 0; i < (limitTo); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }


}