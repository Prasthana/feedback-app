import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;


const colorPrimary = Color.fromRGBO(60, 168, 216, 1);
const colorAccent = Colors.greenAccent;
const colorText = Color.fromRGBO(0, 0, 0, 1);
const colorStagingHeader = Colors.blue;
const colorProductionHeader = Colors.transparent;

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: colorPrimary,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white,
                                   titleTextStyle: TextStyle (
                                                    fontFamily: constants.uberMoveFont,
                                                    fontSize: 25,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(0, 0, 0, 1)),
                                                    
                                    shadowColor: Colors.grey,),    
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: colorAccent),

    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.red,
                                           contentTextStyle: TextStyle (
                                                    fontFamily: constants.uberMoveFont,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal)
    ),
        );

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: colorPrimary,
  hintColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: colorAccent),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
);
