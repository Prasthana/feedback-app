//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/api_services.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/screens/login/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:feedbackapp/constants.dart' as constants;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formState = GlobalKey<FormState>();
  String? _enteredEmail;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(constants.txtLogin),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                constants.enterYourEmailText,
                style: TextStyle(
                    fontFamily: 'UberMove',
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                constants.sendConfirmationCodeText,
                style: TextStyle(
                    fontFamily: 'UberMove',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formState,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: null,
                          errorStyle: TextStyle(
                            fontFamily: 'UberMove',
                          ),
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'UberMove',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) {
                          _enteredEmail = value;
                        },
                        validator: _validateEmail,
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 58.0,
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            _genarateOtp(_enteredEmail,context);
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(constants.txtLogin),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: const Color.fromRGBO(173, 173, 173, 1),
                        textColor: Colors.white,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

String? _validateEmail(String? email) {
  // Improved email validation using a regular expression
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$");
  if (email == null || email.isEmpty || !emailRegExp.hasMatch(email)) {
    return constants.enterValidEmailText;
  } else {
    return null; // No error
  }
}

_genarateOtp(String? email,BuildContext context) async {
  
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  var request = EmailOTPRequest(
      email: email as String,
      deviceType: Platform.operatingSystem
    );

  logger.e('email request -- ${request.toJson()}');
  client.sendEmailOTP(request).then((val) {
    // do some operation
    logger.e('email response -- ${val.toJson()}');

    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OtpView(emailOTPResponse: val)));

  }).catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case const (DioException):
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioException).response;
        logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
        break;
      default:
        break;
    }
  });

}


