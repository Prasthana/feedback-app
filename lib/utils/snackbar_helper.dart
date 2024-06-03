import 'package:flutter/material.dart';
import 'package:feedbackapp/main.dart';

displayErrorToUser(BuildContext context, String alertText) {

  var mySnackBar = SnackBar(content: Text(alertText));
  rootScaffoldMessengerKey.currentState?.showSnackBar(mySnackBar);

}