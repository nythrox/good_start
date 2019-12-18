import 'package:good_start/src/pages/authentication/components/register/models/register_dto.dart';
import 'package:good_start/src/pages/authentication/models/auth_response.dart';
import 'package:good_start/src/pages/authentication/repositories/authentication_repository.dart';
import 'package:good_start/src/shared/bloc/auth_bloc.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {

  
  final AuthenticationRepository _authenticationRepository;

  @observable
  String name;

  @observable
  String email;

  @observable
  String password;

  @observable
  ObservableFuture<AuthResponse> registerResponse;

  _RegisterStore(this._authenticationRepository);

  @action
  Future<void> register(RegisterDto registerDto) async {
    registerResponse = ObservableFuture(_authenticationRepository.register(registerDto));
  }


}