import 'package:feedbackapp/managers/apiservice_manager.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });
    ApiManager.authenticated.performPrepareCall().then((val) {
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

  // Example condition flags
  bool showExtraItem1 = false;

  List<BottomNavigationBarItem> bottomNavItems() {
    List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
    ];

    if (showExtraItem1) {
      bottomNavItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'People',
      ));
    }

    return bottomNavItems;
  }

  Widget bottomWidgets() {
    List<Widget> bottomWidgets = [
      /// Home Page
      const MainHomePageView()
    ];

    if (showExtraItem1) {
      /// Settings page
      bottomWidgets.add(const SettingsView());
    }
    return bottomWidgets[currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationItems = bottomNavItems();
    var numberOfItems = bottomNavigationItems.length;
    /*
    if (numberOfItems >= 2) {
      return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavigationItems,
          currentIndex: currentPageIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        body: bottomWidgets(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body:  const MainHomePageView()
      );
    }
    */
    // _isLoading
    //       // ? const LinearProgressIndicator()
    //       ? const RefreshProgressIndicator(semanticsValue: 'Logout')
    //       // CircularProgressIndicator()

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      bottomNavigationBar: numberOfItems >= 2
          ? BottomNavigationBar(
              items: bottomNavigationItems,
              currentIndex: currentPageIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            )
          : null,
      body: _isLoading
          ? const CircularProgressIndicator()
          : (numberOfItems >= 2 ? bottomWidgets() : const MainHomePageView()),
    );
  }
}
