//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

String? _validateEmail(String? email) {
    // Improved email validation using a regular expression
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$");
    if (email == null || email.isEmpty) {
      return 'Please enter your email address';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null; // No error
  }

class _LoginViewState extends State<LoginView> {

final _formState = GlobalKey<FormState>();

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
                    fontFamily: 'RobotoMono',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                ),
          
                const Text(
                  "We'll send you a confirmation code.",
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
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
                          decoration:   const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter email',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) { },
                          validator: _validateEmail,
                        ),
          
                        const SizedBox(
                          height: 45,
                        ),

                      MaterialButton(
                        minWidth: double.infinity,
                        height: 58.0,
                        onPressed: () {
                          debugPrint('cliked on 1------->>>');
                          if (_formState.currentState!.validate()) {
                            debugPrint('cliked on 2------->>>');
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
                    )
                  ),
            ],
          ),
        ),
      ),
    );
  }

}


