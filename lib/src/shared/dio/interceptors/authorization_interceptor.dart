import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:good_start/src/shared/dio/exceptions/session_expired_exception.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';

class AuthrizationInterceptor extends Interceptor {
  @override
  Future<Options> onRequest(RequestOptions options) async {
    final accessTokenBox = await Hive.openBox(AccessTokenBox);

    String jwtAccessToken = accessTokenBox.getAt(0);

    final Map<String, dynamic> accessTokenPayload = base64ToJson(jwtAccessToken.split('.')[0]);

    if (isJwtExpired(accessTokenPayload['exp'])) {
      final refreshTokenBox = await Hive.openBox(RefreshTokenBox);
      String jwtRefreshToken = refreshTokenBox.getAt(0);
      final newAccessToken = await getNewAuthToken(jwtRefreshToken);
      refreshTokenBox.close();
      return options..headers["Authorization"] = "Bearer $newAccessToken";
    }

    accessTokenBox.close();
    return options;
  }

  Future<String> getNewAuthToken(String refreshToken) async {
    try {
      final response = await Dio().post(
          "https://localhost:7000/api/auth/refresh",
          data: {"refreshToken": refreshToken});
      final String accessToken = response.data["accessToken"];
      return accessToken;
    } catch (e) {
      throw SessionExpiredException();
    }
  }

  bool isJwtExpired(int expiration) {
    final exp = DateTime.fromMicrosecondsSinceEpoch(expiration);
    return exp.isAfter(DateTime.now());
  }

  Map<String, dynamic> base64ToJson(String part) {
    return jsonDecode(utf8.decode(base64.decode(part)));
  }
}
