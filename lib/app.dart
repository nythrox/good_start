import 'package:flutter/material.dart';
import 'package:good_start/login/login_screen.dart';


class App extends StatelessWidget {
 
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Good Start"),
        centerTitle: true,
      ),
      body: InitalPage(),
    );
  }
}