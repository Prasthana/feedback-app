//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:oneononetalks/api_services/models/emailotp.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/screens/otp/otp_view.dart';
import 'package:oneononetalks/screens/login/environment_setting_view.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/snackbar_helper.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/api_services/api_errohandler.dart';
import 'package:oneononetalks/api_services/api_service.dart';

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

  //initializing the API Service class
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    showNetworkLogger(context);
  }

  navigateToEnvironmnetSetup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const EnvironmentSettingView()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(constants.txtLogin),
            // backgroundColor: Colors.white,
           actions: <Widget>[
            Visibility(
              visible: EnvironmentManager.currentEnv.name == constants.stagingText,
              child: IconButton(
                icon: const Icon(Icons.settings),
                iconSize: 32.0,
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const EnvironmentSettingView()));
                },
              ),
            )
          ],
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
                            hintText: constants.enterEmailHintText,
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
                            if (email?.isEmpty == true || (email != null && EmailValidator.validate(email))) {
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
                              showLoader(context);
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
                    )),
              ],
            ),
          ),
        ),
      
    );
  }

  _genarateOtp(String? email, BuildContext context) async {
    var request = EmailOTPRequest(
        email: email as String, deviceType: Platform.operatingSystem);

    _apiService.sendOTP(request).then((value) {
        hideLoader();

      EmailOTPResponse? response = value.data;
      if (value.getException != null) {
        //if there is any error ,it will trigger here and shown in snack-bar
        ErrorHandler errorHandler = value.getException;
        String msg = errorHandler.getErrorMessage();
        //got the exception and disabling the loader
        // setState(() {
        //   _isLoading = false;
        // });
        // SnackBarUtils.showErrorSnackBar(context, msg);
        displaySnackbar(context, msg);
      } else {
        //got the response and disabling the loader
      // setState(() {
      //   _isLoading = false;
      //   _mPostList.addAll(response);
      // });
      navigateToOTPScreen(response);
      }
    
    });
  }

  navigateToOTPScreen(EmailOTPResponse? response) {
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                OtpView(emailOTPResponse: response ?? EmailOTPResponse())));

  }
}
