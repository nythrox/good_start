import 'dart:convert';

import 'package:dio/dio.dart';

class AuthrizationInterceptor extends Interceptor {
  @override
  Future<Options> onRequest(RequestOptions options) async {
    const String jwtAccessToken = "asdfgrwr245gerwasd.2ewdefr452rewrfsfewfeFEefeSDADSa.SDAEDWFSsdasd";
    const String jwtRefreshToken = "2ewdefr452rewrfsfewfeFEefeSDADSa.2ewdefr452rewrfsfewfeFEefeSDADSa.2ewdefr452rewrfsfewfeFEefeSDADSa";
    final Map<String, dynamic> payload =
        base64ToJson(jwtAccessToken.split('.')[0]);
    if (isJwtExpired(payload['exp'])) {
      final newAccessToken = await getNewAuthToken(jwtRefreshToken);
      return options..headers["Authorization"] = "Bearer $newAccessToken";
    }
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
      throw new Exception("Refresh Token failed. Please autheticate again.");
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
