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
final textController = TextEditingController();

  String? get value => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 30,
                ),
          
                  Form(
                    key: _formState,
                    child: Column(
                      children: [
          
                       TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration:  const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter email',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value1) {
                           // valuee = value1;
            
                          },
                          
                        // controller: textController,
                          validator:  (value) {
                            return value!.isEmpty ? 'Please enter email' : null;
                          },
                          // validator: (value) {
                          //   if (value == '') {
                          //     return "Enter valid email";
                          //   }
                          // },
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
                        child: const Text('Login'),
                        shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0), // Set the corner radius
                               ),
                        color: Colors.grey,
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