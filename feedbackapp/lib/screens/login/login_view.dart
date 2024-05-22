//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String baseUrl = 'https://pug-stirring-hopefully.ngrok-free.app';
final String sendEmailUrl = '/users/send_email_auth_code';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formState = GlobalKey<FormState>();
  String? _enteredEmail;

   final TextEditingController _controller = TextEditingController();
   Future<EmailAuthModel>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Enter Your Work Email',
                style: TextStyle(
                    fontFamily: 'UberMove',
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "We'll send you a confirmation code.",
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
                              color: Colors.blue, // Set desired border color
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
                           // _futureAlbum = fetchLoginId(_enteredEmail);
                            _genarateOtp(_enteredEmail);
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: const Text('Login'),
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
    return "Please enter a valid mail";
  } else {
    return null; // No error
  }
}

_genarateOtp(String? email) async {
  debugPrint("email ----->>>> $email");

  final response = await http.post(
    Uri.parse(baseUrl + sendEmailUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email as String,
      'device_name': 'Realme Narzo',
      'device_type': 'android',
      'mobile_type': 'android',
      'device_uid': 'avada kadavra'
    }),
  );
  debugPrint("response code ----->>>> ${response.statusCode}");
  if (response.statusCode == 200) {
    debugPrint("response body2 ----->>>> ${response.body}");
  } else {
    debugPrint("response error --->>> ${response.reasonPhrase}");
  }
}



Future<EmailAuthModel> fetchLoginId(String? email) async {
  debugPrint("email ----->>>> $email");

  final response = await http.post(
    Uri.parse(baseUrl + sendEmailUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email as String,
      'device_name': 'Realme Narzo',
      'device_type': 'android',
      'mobile_type': 'android',
      'device_uid': 'avada kadavra'
    }),
  );
  
  debugPrint("response code ----->>>> ${response.statusCode}");

  if (response.statusCode == 200) {
    var emailAuthModel = EmailAuthModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return emailAuthModel;
  } else {
    debugPrint("response error --->>> ${response.reasonPhrase}");
    throw Exception('Failed to create EmailAuthModel.');
  }
}


class EmailAuthModel {
  final String email;
  final int id;

  EmailAuthModel(this.email, this.id);

  factory EmailAuthModel.fromJson(Map<String, dynamic> json) =>
      EmailAuthModel(json['email'] as String, json['id'] as int);
}
