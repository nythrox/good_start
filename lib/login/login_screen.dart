import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  SnackBar snack(String text, int color){
    return SnackBar(content: Text(text), backgroundColor: Color(color),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper1.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 200.0,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                        hintText: "Input your Email here",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 0.5),
                        )),
                    validator: ((value) =>
                        value.contains("@") && value.contains(".")
                            ? null
                            : "Please enter a valid email!"),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                        hintText: "Input your Password here",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 0.5),
                        )),
                    validator: ((value) => value.length >= 8 &&
                            value.length <= 15
                        ? null
                        : "The password must contain at least 8 characters and the max of 16!"),
                  ),
                ],
              ),
            ),
            RaisedButton.icon(
              label: Text("Submit"),
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _formKey.currentState.validate()
                 ? Scaffold.of(context).showSnackBar( snack("Processing Data...", 0XFF126315))
                     : Scaffold.of(context).showSnackBar( snack("Error processing data!", 0XFFC71A1A));
              },
            )
          ],
        ),
      ),
    );
  }
}
