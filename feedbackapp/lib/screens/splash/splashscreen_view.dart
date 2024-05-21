import 'dart:async';

import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/mainTab/maintab_view.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  bool isLoggedIn() {
    return true;
  }
  
  @override 
    void initState() { 
    super.initState(); 
    Timer(const Duration(seconds: 2), 
          ()=>Navigator.pushReplacement(context, 
                                        MaterialPageRoute(builder: 
                                                          (context) =>  
 isLoggedIn() ? const MainTabView() : const LoginView(), fullscreenDialog: true                                                         ) 
                                       ) 
         ); 
  } 

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // theme: Theme(scaffoldBackgroundColor: Colors.white),
        children: [
          feedbackLogo(),
          const SizedBox(height: 30), // Add some space between the image and the text
          const CircularProgressIndicator()
        ]);
  }

  Padding feedbackLogo() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Image.asset(
          'assets/splash-image.png',
          // height: 400,
          // width: 400,
        ) // Image.asset
        );
  }
}
