
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;


class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  Future<List<Employee>> employeesFuture = ApiManager.authenticated.fetchEmployeesList();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
      title: const Text(constants.reportingTeamTitle, style: TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
      ),

      body: Center(
      child: FutureBuilder<List<Employee>>(
        future: employeesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final employees = snapshot.data!;
            return buildEmployeesList(employees);
          } else {
            return const Text(constants.noDataAvailable);
          }
        },
      ),
    ),
    );
  }

  Widget buildEmployeesList(List<Employee> employeeList) {
    return ListView.builder(
      itemCount: employeeList.length,
      itemBuilder: (context, index) {
        final employee = employeeList[index];
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
              Expanded(flex: 3, child: Text(employee?.name ?? "DUMMY")),
            ],
          ),
        );
      },
    );
  }
}