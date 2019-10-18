import 'package:flutter/material.dart';

ThemeData get appTheme => ThemeData(
    primaryColor: Colors.redAccent[700],
    accentColor: Colors.blue[900],
    brightness: Brightness.light,
    textTheme: TextTheme(
        body1: TextStyle(fontSize: 18), title: TextStyle(fontSize: 22)));

ThemeData get authenticationTheme =>
    ThemeData(inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.withOpacity(0.9), width: 1)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.withOpacity(0.9), width: 1)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.withOpacity(0.9), width: 1)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.withOpacity(0.9), width: 1)),
    ));

TextStyle get authenticationLabel => TextStyle(color: Color(0xfff65e5c),fontWeight: FontWeight.w500,fontSize: 20);

TextStyle get moduleWidgetTitle => TextStyle(color: Colors.white, fontSize: 25);
TextStyle get moduleWidgetSubtitle => TextStyle(color: Colors.white, fontSize: 15);