// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterStore on _RegisterStore, Store {
  final _$nameAtom = Atom(name: '_RegisterStore.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_RegisterStore.email');

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

  final _$passwordAtom = Atom(name: '_RegisterStore.password');

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

  final _$registerResponseAtom = Atom(name: '_RegisterStore.registerResponse');

  @override
  ObservableFuture<AuthResponse> get registerResponse {
    _$registerResponseAtom.context.enforceReadPolicy(_$registerResponseAtom);
    _$registerResponseAtom.reportObserved();
    return super.registerResponse;
  }

  @override
  set registerResponse(ObservableFuture<AuthResponse> value) {
    _$registerResponseAtom.context.conditionallyRunInAction(() {
      super.registerResponse = value;
      _$registerResponseAtom.reportChanged();
    }, _$registerResponseAtom, name: '${_$registerResponseAtom.name}_set');
  }

  final _$registerAsyncAction = AsyncAction('register');

  @override
  Future<void> register(RegisterDto registerDto) {
    return _$registerAsyncAction.run(() => super.register(registerDto));
  }
}
