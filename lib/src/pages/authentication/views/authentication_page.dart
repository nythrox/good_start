import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/components/login/views/login_page.dart';
import 'package:good_start/src/pages/authentication/components/register/views/register_page.dart';
import 'package:good_start/src/shared/components/button.dart';
// import 'package:good_start/src/pages/authentication/authentication_page_bloc.dart';
// import 'package:good_start/src/pages/register/register_page.dart';
// import 'package:good_start/src/shared/components/fullwidth_border_button.dart';
// import 'package:good_start/src/shared/components/fullwidth_button.dart';
import 'package:good_start/src/shared/styles/style.dart';


class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  // AuthenticationPageBloc bloc = AuthenticationPageBloc();

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/images/wallpaper1.jpg"),
              fit: BoxFit.cover),
          color: Colors.purple),
      child: PageView(
        // controller: bloc.pageController,
        children: <Widget>[
          RegisterPage(),
          // AuthenticationHome(bloc: bloc),
          AuthenticationHome(),
          LoginPage()
        ],
      ),
    );
  }
}

class AuthenticationHome extends StatelessWidget {
  const AuthenticationHome({
    Key key,
    // @required this.bloc,
  }) : super(key: key);

  // final AuthenticationPageBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.withOpacity(0.8),
      child: Theme(
        data: authenticationTheme,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "lib/assets/images/logo.png",
                    height: 100,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Button(
                    borderColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Text("REGISTRAR",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    borderRadius: 30,
                    highlightBorderColor: Colors.white,
                    onPressed: () {
                      // bloc.pageController.animateToPage(0,
                      //     duration: Duration(milliseconds: 300),
                      //     curve: Curves.easeOut);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 30,
                    onPressed: () {
                      // bloc.pageController.animateToPage(2,
                      //     duration: Duration(milliseconds: 300),
                      //     curve: Curves.easeOut);
                    },
                    child: Text("LOGIN",
                        style: TextStyle(color: Colors.red, fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
