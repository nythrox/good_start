import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:good_start/src/pages/authentication/components/register/blocs/register_store.dart';
import 'package:good_start/src/pages/authentication/components/register/models/register_dto.dart';
import 'package:good_start/src/pages/authentication/exceptions/auth_exceptions.dart';
import 'package:good_start/src/pages/authentication/repositories/authentication_repository.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/shared/bloc/auth_bloc.dart';
import 'package:good_start/src/shared/components/button.dart';
import 'package:good_start/src/shared/dio/custom_dio.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:mobx/mobx.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // LoginBloc bloc = LoginBloc();
  RegisterStore registerStore =
      RegisterStore(AuthenticationRepository(CustomDio([])));
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final disposer = autorun((_) {
      if (registerStore.registerResponse.status == FutureStatus.fulfilled) {
        final authBloc = AuthBloc();
        var registerResponse;
        authBloc.addUser(registerResponse.value.user);
        authBloc.dispose();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if (registerStore.registerResponse.status == FutureStatus.rejected)
        showDialog(
            context: context,
            builder: (context) {
              String text =
                  "Ocorreu um erro inesperado. Por favor, tente novamente.";
              if (registerStore.registerResponse.error is AuthException) {
                text = registerStore.registerResponse.error.message;
              }
              return AlertDialog(
                title: Text("Erro"),
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.97),
      child: Theme(
        data: authenticationTheme,
        child: Form(
          autovalidate: true,
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image.asset(
                'lib/assets/images/logo.png',
                width: 120,
              )),
              SizedBox(
                height: 50,
              ),
              Text("Nome", style: authenticationLabel),
              TextFormField(
                onSaved: (name) {
                  registerStore.name = name.trim();
                },
                validator: (name) {
                  if (name.length < 3)
                    return "Por favor, insira um nome com mais de três caracteres.";
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "OliviaOliveira",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(height: 30),
              Text("Email", style: authenticationLabel),
              TextFormField(
                onSaved: (email) {
                  registerStore.email = email.trim();
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
                  registerStore.password = password;
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
                if (registerStore.registerResponse?.status ==
                    FutureStatus.pending)
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
                    registerStore.register(RegisterDto(
                        name: registerStore.name,
                        email: registerStore.email,
                        password: registerStore.password));
                  }
                },
                width: MediaQuery.of(context).size.width,
                borderRadius: 30,
                child: Text("REGISTER",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
