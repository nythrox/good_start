import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/views/authentication_page.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: AuthenticationPage());
  }

  @override
  void initState() {
    super.initState();
    final appDocumentDir = getApplicationDocumentsDirectory();
    appDocumentDir.then((dir) {
      Hive.init(dir.path);  
      Hive.registerAdapter(UserAdapter(), 0);
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
