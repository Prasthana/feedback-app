import 'package:feedbackapp/screens/employees/employee_list_view.dart';
import 'package:feedbackapp/screens/home/mainhome_page.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/constants.dart' as constants;


class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {

   int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          // NavigationDestination(
          //   icon: Badge(child: Icon(Icons.settings)),
          //   label: 'Settings',
          // ),
            NavigationDestination(
            icon: Badge(child: Icon(Icons.people)),
            label: constants.reportingTeamTitle,
          ),
        ],
      ),
      body: <Widget>[

        /// Home Page    
        const MainHomePageView(),

        // /// Settings page
        // const SettingsView()

        /// Employees page
        const EmployeeListView()

      ][currentPageIndex],
    );
  }
 
}