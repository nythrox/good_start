import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "Input your Email here",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor, width: 0.5),
                )),
                validator: ((value) =>  value.contains("@") && value.contains(".") ? null : "Please enter a valid email!" ),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Input your Password here",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor, width: 0.5),
                )),
                validator: ((value) =>  value.length >= 8 && value.length <= 15 ? null : "The password must contain at leat 8 characters and the max of 16!" ),
              ),
              FlatButton.icon(
                label: Text("Submit"),
                icon: Icon(Icons.arrow_forward),
                onPressed: (){
                   _formKey.currentState.validate() ?  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data'))) : Text("erro");

                },
              )
            ],
          ),
        )
      ],
    );
  }
}