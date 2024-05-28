
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeesresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
<<<<<<< HEAD
  Future<List<Employee>> employeesFuture = ApiManager.authenticated.fetchEmployeesList();
  
  

  List<Employee> employeesList = [ Employee(id: 123,name: "One 1",designation: "Hello", email: "abc@xyz.com"),
  Employee(id: 123,name: "One 2",designation: "Hello", email: "abc@xyz.com"),
  Employee(id: 123,name: "One 3",designation: "Hello", email: "abc@xyz.com"),
  ];

   @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(constants.reportingTeamTitle)),
      body: ListView.builder(
          itemCount: employeesList.length,
          itemBuilder: (BuildContext context, int index) {
            final employee = employeesList?[index];

            return Column(
        children: <Widget>[
          ListTile(
                // leading:  TextDrawable(text: employee?.name ?? ""),
                leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(157, 149, 252, 1),
                maxRadius: 28.0,
                foregroundImage: NetworkImage(""),
                child: Text(getInitials(employee?.name ?? "", 2),
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                ),
                trailing: const Icon(Icons.chevron_right),
                title: Text(employee?.name ?? "",
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(0, 0, 0, 1)),),
                subtitle: Text(employee?.designation ?? "",
                 style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 1)),),
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
      }),
          
    );
  }
  /*
  //ApiManager.authenticated.fetchEmployeesList();
=======
  Future<EmployeesResponse> employeesFuture = ApiManager.authenticated.fetchEmployeesList();
>>>>>>> dev
  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      appBar: AppBar( title: const Text(constants.reportingTeamTitle)),
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
    );
  }
  */

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
      itemBuilder: (context, index) {
        final employee = employeeList?[index];
        return Container(
          width: double.infinity,
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 76,
          child: Row(
            children: <Widget> [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextDrawable(
            //     height: 54.0,
            //     width: 54.0,
            //     boxShape: BoxShape.circle,
            //     text: employee?.name ?? "")
            // ),

              Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                employee?.name ?? "",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                employee?.designation ?? "",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

            ],

          )
          
          // child: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     // Expanded(flex: 1, child: Image.asset('assets/splash-image.png')),
          //     Expanded(flex: 1, 
          //     child: TextDrawable(
          //       height: 54.0,
          //       width: 54.0,
          //       boxShape: BoxShape.circle,
          //       text: employee?.name ?? "")
          //       ),
          //     Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Expanded(flex: 2, child: Text(employee?.name ?? "")),
          //       Expanded(flex: 2, child: Text(employee?.designation ?? "")),
          //     ],
          //     ),
          //     // Expanded(flex: 3, child: Text(employee?.name ?? "")),
          //     // Expanded(flex: 3, child: Text(employee?.designation ?? "")),
          //   ],
          // ),
        );
      },
    );
  }


  Widget buildEmptyListView() {
    return
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
child:
     Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
               Image.asset('assets/emptyOneOnOneList.png', height: 250),
          addVerticalSpace(20),
          const Text('No Employees Added',style: TextStyle (
                    fontFamily: constants.uberMoveFont,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    ),
          ),
          addVerticalSpace(20),
          const Text(
                  'You can add employees  by clicking on the plus icon below.',style: TextStyle (
                    fontFamily: constants.uberMoveFont,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    ),),
        ],
      ),
    ));
  }
}