import 'dart:convert';

import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/employees/employee_list_view.dart';
import 'package:feedbackapp/screens/home/mainhome_page.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;



class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int currentPageIndex = 0;
  bool _isLoading = false;
  // Example condition flags
  bool hasAccessForTeamTab = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });
    ApiManager.authenticated.performPrepareCall().then((val) {

      String prepareResponce = jsonEncode(val.toJson());
      var sm = StorageManager();
      sm.saveData(constants.prepareCallResponse, prepareResponce).then((val) {
      });

     Permission? tabTabAccess = val.user?.permissions?["teams.tab"];

     if (tabTabAccess?.access == Access.enabled) {
        hasAccessForTeamTab = true;
     } else {
      hasAccessForTeamTab = false;
     }
     
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }


  List<BottomNavigationBarItem> bottomNavItems() {
    List<BottomNavigationBarItem> bottomNavItems = [
       BottomNavigationBarItem(
        icon: Image.asset('assets/bottomBarCalendarIcon.png',width: 24,height: 24,),
        label: '',
        activeIcon: Image.asset('assets/icOneonOne.png',width: 24,height: 24,)
      ),
    ];

    if (hasAccessForTeamTab) {
      bottomNavItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: '',
      ));
    }

    return bottomNavItems;
  }

  Widget bottomWidgets() {
    List<Widget> bottomWidgets = [
      /// Home Page
      const MainHomePageView()
    ];

    if (hasAccessForTeamTab) {
      /// Settings page
      bottomWidgets.add(const EmployeeListView());
    }
    return bottomWidgets[currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationItems = bottomNavItems();
    var numberOfItems = bottomNavigationItems.length;
 
    return Scaffold(
      bottomNavigationBar: numberOfItems >= 2
          ? BottomNavigationBar(
              items: bottomNavigationItems,
              currentIndex: currentPageIndex,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
            )
          : null,
      body: _isLoading
          ? const Center ( child:  CircularProgressIndicator())
          : (numberOfItems >= 2 ? bottomWidgets() : const MainHomePageView()),
    );
  }
}
