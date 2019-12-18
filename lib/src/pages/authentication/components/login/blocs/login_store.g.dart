// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$emailAtom = Atom(name: '_LoginStore.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$loginResponseAtom = Atom(name: '_LoginStore.loginResponse');

  @override
  ObservableFuture<AuthResponse> get loginResponse {
    _$loginResponseAtom.context.enforceReadPolicy(_$loginResponseAtom);
    _$loginResponseAtom.reportObserved();
    return super.loginResponse;
  }

  @override
  set loginResponse(ObservableFuture<AuthResponse> value) {
    _$loginResponseAtom.context.conditionallyRunInAction(() {
      super.loginResponse = value;
      _$loginResponseAtom.reportChanged();
    }, _$loginResponseAtom, name: '${_$loginResponseAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login(LoginDto loginDto) {
    return _$loginAsyncAction.run(() => super.login(loginDto));
  }
}
