import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:oneononetalks/api_services/api_client.dart';
import 'package:oneononetalks/api_services/models/emailotp.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/api_services/models/verifyotp.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/mainTab/maintab_view.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/local_storage_manager.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:dio/dio.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class OtpView extends StatefulWidget {
  OtpView({super.key, required this.emailOTPResponse});

  EmailOTPResponse emailOTPResponse;
  
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool isEnableConfirmBtn = false;
  bool isEnableResendBtn = true;
  bool isNotValidOTP = false;
  String enteredOTP = "";
  String resendText = constants.resend;
  var counterForResend = constants.resendTime;
  List<TextEditingController?> otpControllers = [];

  void setEnableConfirmBtn(bool newValue) {
    setState(() {
      isEnableConfirmBtn = newValue;
    });
  }

  void setValidOTPStatus(bool newValue) {
    setState(() {
      isNotValidOTP = newValue;
    });
    if(isNotValidOTP){
      clearOtpFields();
    }
  }

  void setEnableResendBtn(bool newValue) {
    setState(() {
      isEnableResendBtn = newValue;
    });
  }

  void setEnteredOTP(String newValue) {
    setState(() {
      enteredOTP = newValue;
    });
  }

  void setResendText(String newValue) {
    setState(() {
      resendText = newValue;
    });
  }
  
  void clearOtpFields() {
    for (var controller in otpControllers) {
      controller?.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(constants.txtLogin),
      ),
      body: Container(
        padding: const EdgeInsets.all(36.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                constants.verifyYourEmail,
                style: TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(4, 4, 4, 1)),
              ),
              addVerticalSpace(16),
              const Text(
                constants.enterCodeSentTo,
                style: TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(4, 4, 4, 1)),
              ),
              addVerticalSpace(4),
              Text(
                widget.emailOTPResponse.userLogin?.email ?? "",
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(22, 97, 210, 1)),
              ),
              addVerticalSpace(24),
              SizedBox(
                width: double.infinity,
                child: OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  numberOfFields: 6,
                  fieldHeight: 56.0,
                  fieldWidth: 48.0,
                  borderColor: const Color.fromARGB(255, 18, 17, 17),
                  focusedBorderColor: const Color.fromARGB(255, 18, 17, 17),
                  disabledBorderColor: const Color.fromARGB(255, 18, 17, 17),
                  enabledBorderColor: const Color.fromARGB(255, 18, 17, 17),
                  showFieldAsBox: true,
                  borderWidth: 1.0,
                  fillColor: Colors.white,
                  filled: true,
                  autoFocus: true,
                  handleControllers: (controllers) {
                    otpControllers = controllers;
                  },
                  onCodeChanged: (value) => {
                    setEnteredOTP(""),
                    setEnableConfirmBtn(false),
                    logger.d("OTP is => $value"),
                  },
                  onSubmit: (code) => {
                    setEnteredOTP(code),
                    setEnableConfirmBtn(true),
                    logger.d("OTP is => $code"),
                  },
                ),
              ),
              addVerticalSpace(8),
              Visibility(
                visible: isNotValidOTP,
                child: const Text(
                  constants.errorEnterValidOTP,
                  style: TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 69, 69, 1)),
                ),
              ),   
              addVerticalSpace(24),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isEnableConfirmBtn
                            ? const Color.fromRGBO(0, 0, 0, 1)
                            : const Color.fromRGBO(173, 173, 173, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    onPressed: () {
                      if (enteredOTP.isEmpty == false) {
                        // showDialog(context: context, builder: (context){
                        //   return CupertinoAlertDialog(title: const Text("Verification Code"),
                        //     content: Text('Code entered is $enteredOTP'),
                        // );
                        // });
                        showLoader(context);
                        _validateOTP(
                            widget.emailOTPResponse.userLogin?.id ?? -1, enteredOTP, context);                        
                      }
                    },
                    child: Text(constants.confirm,
                        style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: isEnableConfirmBtn
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)))),
              ),
              addVerticalSpace(8),
              const Center(
                child: Text(
                  constants.haveNotReceivedCodeYet,
                  style: TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (isEnableResendBtn == true) {
                      setEnableResendBtn(false);
                      _genarateOtp(widget.emailOTPResponse.userLogin?.email, context);
                      clearOtpFields();
                      Timer.periodic(const Duration(seconds: 1), (timer) {
                        // print(timer.tick);
                        counterForResend--;
                        setResendText(
                            "${constants.resend} in $counterForResend sec");
                        if (counterForResend == 0) {
                          counterForResend = constants.resendTime;
                          setResendText(constants.resend);
                          // print('Cancel timer');
                          setEnableResendBtn(true);
                          timer.cancel();
                        }
                      });
                    }
                  },
                  child: Text(
                    resendText,
                    style: TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: isEnableResendBtn
                            ? const Color.fromRGBO(22, 97, 210, 1)
                            : const Color.fromARGB(255, 169, 191, 224)),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  _validateOTP(int id, String authCode, BuildContext context) async {
    var request = VerifyEmailOTPRequest(id: id, emailAuthCode: authCode);

    setValidOTPStatus(false);
    ApiManager.public.verifyEmailOTP(request).then((val) {
      // do some operation
      logger.e('email response -- ${val.toJson()}');
      _getLoginToken(val, context);

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OtpView(emailOTPResponse: val)));
    }).catchError((obj) {
      // non-200 error goes here.
      hideLoader();
      switch (obj.runtimeType) {
        case const (DioException):
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioException).response;
          logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
          setValidOTPStatus(true);
          break;
        default:
          break;
      }
    });
  }

  _getLoginToken(VerifyEmailOTPResponse mVerifyEmailOTPResponse,
      BuildContext context) async {
    var request = LoginTokenRequest(
        grantType: constants.grantTypePassword,
        clientId: constants.clientId,
        clientSecret: constants.clientSecret,
        loginToken: mVerifyEmailOTPResponse.userLogin?.loginToken ?? "NoTOKEN");

    ApiManager.public.generateLoginToken(request).then((val) {
      // do some operation
      logger.e('email response -- ${val.toJson()}');
      String user = jsonEncode(val.toJson());
      var sm = StorageManager();
      hideLoader();
      
      LocalStorageManager.shared.loginUser = val.user;
      sm.saveData(constants.loginTokenResponse, user).then((val) {
        // do some operation
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainTabView()));
        Navigator.pushAndRemoveUntil<dynamic>(
        context, MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const MainTabView(),),
        (route) => false,//if you want to disable back feature set to false
        );
      });
    
    }).catchError((obj) {
      // non-200 error goes here.
       hideLoader();
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

  _genarateOtp(String? email, BuildContext context) async {
    final client =
        ApiClient(Dio(BaseOptions(contentType: "application/json")));

    var request = EmailOTPRequest(
        email: email as String, deviceType: Platform.operatingSystem);

    logger.e('email request -- ${request.toJson()}');
    client.sendEmailOTP(request).then((val) {
      // do some operation
      logger.e('email response -- ${val.toJson()}');

      widget.emailOTPResponse = val;
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

}
