import 'dart:convert';

import 'package:feedbackapp/api_services/api_errohandler.dart';
import 'package:feedbackapp/api_services/api_service.dart';
import 'package:feedbackapp/api_services/models/preparecallresponse.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/employees/employee_list_view.dart';
import 'package:feedbackapp/screens/home/mainhome_page.dart';
import 'package:feedbackapp/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:network_logger/network_logger.dart';

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

  //initializing the API Service class
  final ApiService _apiService = ApiService();

  @override
  void initState() {

        super.initState();

    NetworkLoggerOverlay.attachTo(context);

    setState(() {
      _isLoading = true;
    });

    _apiService.makePrepareCall().then((value) {
      PrepareCallResponse? response = value.data;
      if (value.getException != null) {
        //if there is any error ,it will trigger here and shown in snack-bar
        ErrorHandler errorHandler = value.getException;
        String msg = errorHandler.getErrorMessage();
        //got the exception and disabling the loader
        setState(() {
          _isLoading = false;
        });
        // SnackBarUtils.showErrorSnackBar(context, msg);
        displaySnackbar(context, msg);
      } else if (response != null) {
        //got the response and disabling the loader
        updatePermissions(response);
        setState(() {
          _isLoading = false;
          // _mPostList.addAll(response);
        });
      } else {
        //when response is null most cases are when status code becomes 204
        //disabling the loader
        updatePermissions(response);
        setState(() {
          _isLoading = false;
        });
      }
    });
    
  }

  updatePermissions(PrepareCallResponse? response) {
            var sm = StorageManager();
        String prepareResponce = jsonEncode(response?.toJson());
        sm.saveData(constants.prepareCallResponse, prepareResponce);
  
        Permission? tabTabAccess = response?.user?.permissions?["teams.tab"];

        if (tabTabAccess?.access == Access.enabled) {
          hasAccessForTeamTab = true;
        } else {
          hasAccessForTeamTab = false;
        }
        setState(() {
          _isLoading = false;
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
          icon: Image.asset(
            'assets/bottomBarCalendarIcon.png',
            width: 24,
            height: 24,
          ),
          label: '',
          activeIcon: Image.asset(
            'assets/icOneonOne.png',
            width: 24,
            height: 24,
          )),
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
          ? const Center(child: CircularProgressIndicator())
          : (numberOfItems >= 2 ? bottomWidgets() : const MainHomePageView()),
    );
  }
}
