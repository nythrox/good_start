import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:good_start/src/pages/authentication/components/login/blocs/login_store.dart';
import 'package:good_start/src/pages/authentication/components/login/models/login_dto.dart';
import 'package:good_start/src/pages/authentication/exceptions/auth_exceptions.dart';
import 'package:good_start/src/pages/authentication/repositories/authentication_repository.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/shared/bloc/auth_bloc.dart';
import 'package:good_start/src/shared/components/button.dart';
import 'package:good_start/src/shared/dio/custom_dio.dart';
// import 'package:good_start/src/pages/login/login_bloc.dart';
// import 'package:good_start/src/shared/components/fullwidth_border_button.dart';
// import 'package:good_start/src/shared/components/fullwidth_button.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore _loginStore =
      LoginStore(AuthenticationRepository(CustomDio([])));
  final formKey = GlobalKey<FormState>();
  ReactionDisposer _disposer;
  final AuthBloc authBloc = BlocProvider.getBloc<AuthBloc>();

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (_loginStore.loginResponse.status == FutureStatus.fulfilled) {
        onSuccess();
      }
      if (_loginStore.loginResponse.status == FutureStatus.rejected)
        showDialog(
            context: context,
            builder: (context) {
              String text =
                  "An unexpected error has occured. Please try again.";
              if (_loginStore.loginResponse.error is AuthException)
                text =
                    (_loginStore.loginResponse.error as AuthException).message;
              // if ((_loginStore.loginResponse.error as DioError)
              //         .response
              //         .statusCode ==
              //     400) text = "Email or password incorrect. Please try again.";
              return AlertDialog(
                title: Text("Error"),
                content: Text(text),
                actions: <Widget>[
                  Button(
                    borderColor: Colors.red,
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
    });
  }

  void onSuccess() {
    authBloc
      ..addUser(_loginStore.loginResponse.value.user)
      ..addAccessToken(_loginStore.loginResponse.value.accessToken)
      ..addRefreshToken(_loginStore.loginResponse.value.refreshToken);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void dispose() {
    _disposer();
    _loginStore.dispose();
    super.dispose();
  }

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
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  'lib/assets/images/logo.png',
                  width: 120,
                )),
                SizedBox(
                  height: 50,
                ),
                Text("Email", style: authenticationLabel),
                TextFormField(
                  onSaved: (email) {
                    _loginStore.email = email.trim();
                  },
                  validator: (email) {
                    if (RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(email))
                      return null;
                    else
                      return "Por favor, insira um email válido";
                  },
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
                  onSaved: (password) {
                    _loginStore.password = password;
                  },
                  validator: (password) {
                    if (password.length < 4)
                      return "Por favor, digite uma senha com mais de 4 caracteres";
                    return null;
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "********",
                      border: UnderlineInputBorder()),
                ),
                Observer(builder: (context) {
                  if (_loginStore.loginResponse?.status == FutureStatus.pending)
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator());
                  return SizedBox(height: 60);
                }),
                Button(
                  color: Colors.red,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _loginStore.login(LoginDto(
                          email: _loginStore.email,
                          password: _loginStore.password));
                    }
                  },
                  width: MediaQuery.of(context).size.width,
                  borderRadius: 30,
                  child: Text("LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Button(
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: Colors.red,
                        child: Text("Google",
                            style: TextStyle(color: Colors.white)),
                        borderRadius: 15,
                        onPressed: () {}),
                    Button(
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: Colors.blue,
                        child: Text("Facebook",
                            style: TextStyle(color: Colors.white)),
                        borderRadius: 15,
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
