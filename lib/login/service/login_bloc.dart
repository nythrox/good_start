import 'package:good_start/login/service/login_service.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final loginBloc = LoginService();
  final _email$ = BehaviorSubject();
  final _password$ = BehaviorSubject();

  login() {
    // Observable.zip2(_email$, _password$, (e, p) => )
  }

  signin(){

  }

  void dispose() { 
    _email$.close();
    _password$.close();
  }
}