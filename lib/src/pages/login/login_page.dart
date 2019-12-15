import 'package:flutter/material.dart';
import 'package:good_start/src/pages/home/home_page.dart';
// import 'package:good_start/src/pages/login/login_bloc.dart';
// import 'package:good_start/src/shared/components/fullwidth_border_button.dart';
// import 'package:good_start/src/shared/components/fullwidth_button.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:hasura_connect/hasura_connect.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.97),
      child: Theme(
        data: authenticationTheme,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            autovalidate: true,
            // key: bloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Image.asset('lib/assets/images/logo.png',width: 120,)),
                SizedBox(height: 50,),
                Text("Email", style: authenticationLabel),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "goodstart@gmail.com.br",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder()),
                ),
                SizedBox(height: 30),
                Text(
                  "Password",
                  style: authenticationLabel,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "********", border: UnderlineInputBorder()),
                ),
                SizedBox(height: 60),
                // FullwidthButton(
                //   color: Colors.red,
                //   onPressed: () {
                //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                //     if (bloc.formKey.currentState.validate()) {
                //       bloc.formKey.currentState.save();
                //     }
                //   },
                //   child: Text("LOGIN",
                //       style: TextStyle(color: Colors.white, fontSize: 18)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
