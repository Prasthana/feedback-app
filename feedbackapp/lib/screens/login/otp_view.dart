import 'dart:async';

import 'package:feedbackapp/api_services/api_services.dart';
import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/verifyotp.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/mainTab/maintab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:dio/dio.dart';
import 'package:feedbackapp/constants.dart' as constants;


class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.emailOTPResponse});

  final EmailOTPResponse emailOTPResponse;
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

   bool isEnableConfirmBtn = false;
   bool isEnableResendBtn = true; 
   String enteredOTP = "";
   String resendText = constants.RESEND;
   var counterForResend = constants.RESEND_TIME;

   void setEnableConfirmBtn(bool newValue){
     setState(() {
      isEnableConfirmBtn = newValue;
     });
   }

   void setEnableResendBtn(bool newValue){
     setState(() {
      isEnableResendBtn = newValue;
     });
   }

   void setEnteredOTP(String newValue){
     setState(() {
      enteredOTP = newValue;
     });
   }

   void setResendText(String newValue){
     setState(() {
      resendText = newValue;
     });
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginView())),
      ), 
      title: const Text(constants.LOGIN,style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
      ),

      body: Container(
        padding: const EdgeInsets.all(36.0),
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start, 
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                 const Text(
                    constants.VERIFY_YOUR_EMAIL, 
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),
                
                const SizedBox(height: 16.0),

                const Text(
                    constants.ENTER_CODE_SEND_TO, 
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),
               
              const SizedBox(height: 4.0),

              Text(
                    widget.emailOTPResponse.email,
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(22, 97, 210, 1)),
              ),
                
              const  SizedBox(height: 24.0),

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
                onCodeChanged: (value) => {
                  setEnteredOTP(""),
                  setEnableConfirmBtn(false),
                  logger.d("OTP is => $value"),
                },
                onSubmit: (code) =>{
                  setEnteredOTP(code),
                  setEnableConfirmBtn(true),
                  logger.d("OTP is => $code"),
                },
                ),
              ),

              const  SizedBox(height: 24.0),

              SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: isEnableConfirmBtn ? const Color.fromRGBO(0, 0, 0, 1) : const Color.fromRGBO(173, 173, 173, 1), 
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)))),
                  onPressed: () {
                  if (enteredOTP.isEmpty == false) {
                      // showDialog(context: context, builder: (context){
                      //   return AlertDialog(title: const Text("Verification Code"),
                      //     content: Text('Code entered is $enteredOTP'),
                      // );
                      // });
                      _validateOTP(widget.emailOTPResponse.id, enteredOTP, context);
                  }
              }, 
              child: Text(constants.CONFIRM,
              style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: isEnableConfirmBtn ? const Color.fromRGBO(255, 255, 255, 1) :  const Color.fromRGBO(0, 0, 0, 1)
              )
              )
              ),
              ),

              const  SizedBox(height: 8.0),

              const Center(child:Text(
                    constants.HAVE_NOT_RECEIVED_CODE, 
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),
                  ),
               
              const SizedBox(height: 4.0),

              Center(child:TextButton(
                    onPressed: () { 
                      if(isEnableResendBtn == true) {
                        setEnableResendBtn(false);
                        Timer.periodic(const Duration(seconds: 1), (timer) {
                          print(timer.tick);
                          counterForResend--;
                          setResendText(constants.RESEND + " in $counterForResend sec");
                          if (counterForResend == 0) {
                            counterForResend = constants.RESEND_TIME;
                            setResendText(constants.RESEND);
                            print('Cancel timer');
                            setEnableResendBtn(true);
                            timer.cancel();
                          }
                        });
                      }
                    },
                    child: Text(resendText,
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: isEnableResendBtn ? const Color.fromRGBO(22, 97, 210, 1) : Color.fromARGB(255, 169, 191, 224)),
                  ),
                  ),
                  ),

              ]
            ),
      ),
    );
  }
}

_validateOTP(int id, String authCode, BuildContext context) async {
 
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  var request = VerifyEmailOTPRequest(
      id: id,
      emailAuthCode: authCode);

  client.verifyEmailOTP(request).then((val) {
    // do some operation
    logger.e('email response -- ${val.toJson()}');

    _getLoginToken(val, context);

    // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OtpView(emailOTPResponse: val)));

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

_getLoginToken(VerifyEmailOTPResponse mVerifyEmailOTPResponse, BuildContext context) async {
 
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  var request = LoginTokenRequest(
      grantType: constants.GRANT_TYPE,
      clientId: constants.CLIENT_ID,
      clientSecret: constants.CLIENT_SECRET,
      loginToken: mVerifyEmailOTPResponse.loginToken);

  client.generateLoginToken(request).then((val) {
    // do some operation
    logger.e('email response -- ${val.toJson()}');

    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const MainTabView()));

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
