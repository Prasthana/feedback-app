
import 'package:feedbackapp/api_services/models/employee.dart';
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
  Future<List<Employee>> employeesFuture = ApiManager.authenticated.fetchEmployeesList();
  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      appBar: AppBar( title: const Text(constants.reportingTeamTitle)),
      body: Center(
      child: FutureBuilder<List<Employee>>(
        future: employeesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final employeesList = snapshot.data;
              var listCount = employeesList?.length ?? 0;
              if (listCount > 0) {
                return buildEmployeesList(employeesList);
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

  Widget buildEmployeesList(List<Employee>? employeeList) {
    return ListView.builder(
      itemCount: employeeList?.length,
      itemBuilder: (context, index) {
        final employee = employeeList?[index];
        return Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.asset('assets/splash-image.png')),
              addHorizontalSpace(10),
              Expanded(flex: 3, child: Text(employee?.name ?? "No Name")),
            ],
          ),
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