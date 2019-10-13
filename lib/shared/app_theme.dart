import 'package:flutter/material.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.blue[900],
        brightness: Brightness.light,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18),
          title: TextStyle(fontSize: 22))
          );
  }
}
