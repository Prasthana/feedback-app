import 'package:feedbackapp/api_services/models/emailotp.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.emailOTPResponse});

  final EmailOTPResponse emailOTPResponse;
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

    bool isEnableConfirmBtn = false;

   void setEnableConfirmBtn(bool newValue){
     setState(() {
      isEnableConfirmBtn = newValue;
     });
  }

  @override
  Widget build(BuildContext context) {
   String enteredOTP = "";

    return Scaffold(
     appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginView())),
      ), 
      title: const Text("Login",style: TextStyle(
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
                    'Verify Your Email', 
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),
                
                const SizedBox(height: 16.0),

                const Text(
                    'Enter the code we sent to ', 
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
                  enteredOTP = "",
                  setEnableConfirmBtn(false),
                  logger.d("OTP is => $value"),
                },
                onSubmit: (code) =>{
                  enteredOTP = code,
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
                      showDialog(context: context, builder: (context){
                        return AlertDialog(title: const Text("Verification Code"),
                          content: Text('Code entered is $enteredOTP'),
                      );
                      });
                  }
              }, 
              child: Text("Confirm",
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
                    'Haven\'t received the code yet? ', 
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),
                  ),
               
              const SizedBox(height: 4.0),

              const Center(child:Text(
                    'Resend', 
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(22, 97, 210, 1)),
                  ),
                  ),


              ]
            ),
      ),
    );

  }
}