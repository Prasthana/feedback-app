//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/screens/otp/otp_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:network_logger/network_logger.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formState = GlobalKey<FormState>();
  String? _enteredEmail;
  var isEmailValidated = false;

  @override
  void initState() {
    super.initState();
    NetworkLoggerOverlay.attachTo(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    child :MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(constants.txtLogin),
          // backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(30),
              const Text(
                constants.enterYourEmailText,
                style: TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                constants.sendConfirmationCodeText,
                style: TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              addVerticalSpace(30),
              Form(
                  key: _formState,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: null,
                          errorStyle: TextStyle(
                            fontFamily: constants.uberMoveFont,
                          ),
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 17, 17),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 17, 17),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 17, 17),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: constants.uberMoveFont,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (email) {
                          setState(() {
                            isEmailValidated = EmailValidator.validate(email);
                          });
                          _enteredEmail = email;
                        },
                        validator: (email) {
                          if (email != null && EmailValidator.validate(email)) {
                            return null;
                          }
                          return constants.enterValidEmailText;
                        },
                      ),
                      addVerticalSpace(45),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 58.0,
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            _genarateOtp(_enteredEmail, context);
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(constants.txtLogin),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: isEmailValidated
                            ? const Color.fromRGBO(0, 0, 0, 1)
                            : const Color.fromRGBO(173, 173, 173, 1),
                        //const Color.fromRGBO(173, 173, 173, 1),
                        textColor: Colors.white,
                      )
                    ],
                  )
                  ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

showInvalidAlert(BuildContext context, String alertText) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
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

_genarateOtp(String? email, BuildContext context) async {
  var request = EmailOTPRequest(
      email: email as String, deviceType: Platform.operatingSystem);

  ApiManager.public.sendEmailOTP(request).then((val) {
    // do some operation
    logger.e('email response -- ${val.toJson()}');

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtpView(emailOTPResponse: val)));
  }).catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case const (DioException):
        // Here's the sample to get the failed response error code and message
        final res = ((obj as DioException).response as Response);
        logger.e('Got error : ${res.statusCode} -> ${res.statusMessage}');
        // debugPrint('statusMessage ------>>> ${res?.statusMessage}');
        final responseData = res.data as Map;
        showInvalidAlert(
            context, responseData['message'] ?? constants.inValidUserText);
        break;
      default:
        break;
    }
  });
}
