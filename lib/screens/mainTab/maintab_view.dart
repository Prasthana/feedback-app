import 'dart:async';
import 'dart:convert';

import 'package:oneononetalks/api_services/api_errohandler.dart';
import 'package:oneononetalks/api_services/api_service.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/employee_list_view.dart';
import 'package:oneononetalks/screens/home/mainhome_page.dart';
import 'package:oneononetalks/screens/splash/biometric_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/snackbar_helper.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with WidgetsBindingObserver{
  int currentPageIndex = 0;
  bool _isLoading = false;
  // Example condition flags
  bool hasAccessForTeamTab = false;

  //initializing the API Service class
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
   // navigateToBiometricView();
    Timer(const Duration(milliseconds: 200), navigateToBiometricView); 
    WidgetsBinding.instance.addObserver(this);
    showNetworkLogger(context);

    setState(() {
      _isLoading = true;
    });

   onPrepareApiCall();
  }

  navigateToBiometricView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BiometricView(), fullscreenDialog: true));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      if (state == AppLifecycleState.resumed) {
      setState(() {
        onPrepareApiCall();
      });
    } else{
      //print(state.toString());
    }
  }

  void onPrepareApiCall(){
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
      } else {
        //got the response and disabling the loader
      updatePermissions(response);
      }
      setState(() {
        _isLoading = false;
      });
    
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
          ? const Center(child: CircularProgressIndicator(backgroundColor: colorPrimary,valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
          : (numberOfItems >= 2 ? bottomWidgets() : const MainHomePageView()),
    );
  }
}
