import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isLoading = false;

  Future<void> _performAction() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or a time-consuming task
    // await Future.delayed(Duration(seconds: 3));

    var sm = StorageManager();

    sm.removeData("TOKEN").then((val) {
      // setState(() {
      //   _isLoading = false;
      // });

      Navigator.popUntil(context, (route) => route.isFirst);
    });

    // Perform your actual action here
    // For example, navigate to another screen or update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          // ? const LinearProgressIndicator()
          ? const RefreshProgressIndicator(semanticsValue: constants.logout ,backgroundColor: colorPrimary,valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
          // CircularProgressIndicator()
          : ElevatedButton(
              onPressed: _performAction,
              child: const Text(constants.logOut),
            ),
    );
    /*
    return Center(
        child: ElevatedButton(
            child: const Text("Logout"),
            onPressed: () => {
                  sm.removeData("TOKEN").then((val) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  })
                }));
                */
  }
}
