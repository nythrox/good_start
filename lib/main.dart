import 'package:flutter/material.dart';
import 'package:good_start/initial_page/inital_page.dart';
import 'package:good_start/shared/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().appTheme(),
      home: InitialPage()
    );
  }
}