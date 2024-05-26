import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:bugsnag_flutter_performance/bugsnag_flutter_performance.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/screens/splash/splashscreen_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

const String bugsnagappid = 'd36c56cbb6e60d544204211d24e9efe8';

var logger = Logger(
  printer: PrettyPrinter(),
  level: Level.all
);


void main() {
  bugsnag.start(apiKey: bugsnagappid);
  bugsnag_performance.start(apiKey: bugsnagappid);
  bugsnag_performance.measureRunApp(() async => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback App',
      theme: lightTheme,
      darkTheme: darkTheme,
      home:  
      const Scaffold(
        backgroundColor: Colors.white, 
        body: SplashScreenView()
      )
    );
  }
}