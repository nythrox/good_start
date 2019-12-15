import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/authentication_page.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/pages/modules/modules_page.dart';
import 'package:good_start/src/shared/styles/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: HomePage()
    );
  }
}