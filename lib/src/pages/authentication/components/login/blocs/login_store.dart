import 'package:good_start/src/pages/authentication/components/login/models/login_dto.dart';
import 'package:good_start/src/pages/authentication/models/auth_response.dart';
import 'package:good_start/src/pages/authentication/repositories/authentication_repository.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  final AuthenticationRepository _authenticationRepository;

  @observable
  String email;

  @observable
  String password;

  @observable
  ObservableFuture<AuthResponse> loginResponse;

  _LoginStore(this._authenticationRepository);

  @action
  Future<void> login(LoginDto loginDto) async {
    loginResponse = ObservableFuture(_authenticationRepository.login(loginDto));
  }

}