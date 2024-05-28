import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;


const colorPrimary = Colors.green;
const colorAccent = Colors.greenAccent;
const colorText = Color.fromRGBO(0, 0, 0, 1);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: colorPrimary,
    appBarTheme: const AppBarTheme(backgroundColor: colorPrimary,
    titleTextStyle: TextStyle (
                    fontFamily: constants.uberMoveFont,
                    fontSize: 32,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(0, 0, 0, 1)),
                    shadowColor: Colors.grey,
                    ),    
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: colorAccent),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: colorPrimary,
  hintColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: colorPrimary),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: colorAccent),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
);
