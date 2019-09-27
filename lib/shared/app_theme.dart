import 'package:flutter/material.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.red,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18),
          title: TextStyle(fontSize: 22))
          );
  }
}
