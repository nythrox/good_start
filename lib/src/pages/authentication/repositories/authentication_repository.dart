import 'package:dio/dio.dart';
import 'package:good_start/src/pages/authentication/components/login/models/login_dto.dart';
import 'package:good_start/src/pages/authentication/components/login/models/login_response.dart';
import 'package:good_start/src/pages/authentication/components/register/models/register_dto.dart';
import 'package:good_start/src/pages/authentication/exceptions/auth_exceptions.dart';
import 'package:good_start/src/pages/authentication/models/auth_response.dart';
import 'package:good_start/src/shared/dio/Icustom_dio.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';

class AuthenticationRepository {
  final ICustomDio _customDio;

  AuthenticationRepository(this._customDio);

  Future<AuthResponse> login(LoginDto loginDto) async {
    try {
      final response = await _customDio.dio.post(
          _customDio.authUrl + 'auth/login',
          data: {"email": loginDto.email, "password": loginDto.password});
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioError && e.response.statusCode == 404)
        throw AuthException(e.response.data["message"].toString());
      if (e is DioError && e.response.statusCode == 401)
        throw AuthException("Password is incorrect");
      rethrow;
    }
  }

  Future<AuthResponse> register(RegisterDto registerDto) async {
    try {
      final response = await _customDio.dio
          .post(_customDio.authUrl + "auth/register", data: {
        "name": registerDto.name,
        "email": registerDto.email,
        "password": registerDto.password
      });
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioError && e.response.statusCode == 400)
        throw AuthException(e.response.data["message"].toString());
      rethrow;
    }
  }
}
