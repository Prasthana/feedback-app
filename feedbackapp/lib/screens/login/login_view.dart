import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.green.shade100,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 50),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Enter Your Work Email',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              ),
          
              const Text(
                'We all send you a confirmation code.',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              ),

              const SizedBox(
                height: 40,
              ),

              Form(child: 
                Padding(
                  padding: const EdgeInsets.only(right: 43),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:  const InputDecoration(
                          labelText: 'Enter Email',
                          hintText: 'Enter email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                  
                        },
                        validator:  (value) {
                          return value!.isEmpty ? 'Please enter email' : null;
                        },
                      ),

                      const SizedBox(
                        height: 45,
                      ),

                      MaterialButton(
                        minWidth: double.infinity,
                        height: 58.0,
                        onPressed: () {

                        },
                        child: const Text('Login'),
                        shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0), // Set the corner radius
                               ),
                        color: Colors.grey,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),

                

                
              )

            ],
          ),
        ),
      ),
    );
    // Center(
    //   child: Text("Email Id")
    // );
  }
}

