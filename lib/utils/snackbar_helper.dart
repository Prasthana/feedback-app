import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;


displayAlert(BuildContext context, String alertText) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text(constants.okButton),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  CupertinoAlertDialog alert = CupertinoAlertDialog(
    content: Text(alertText),
    actions: [
      okButton,
    ],
  );


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  
}


displaySnackbar(BuildContext context, String alertText) {
  rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  var mySnackBar = SnackBar(content: Text(alertText));
  rootScaffoldMessengerKey.currentState?.showSnackBar(mySnackBar);
}