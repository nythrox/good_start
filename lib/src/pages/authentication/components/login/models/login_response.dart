// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final String accessToken;
    final String refreshToken;

    LoginResponse({
        this.accessToken,
        this.refreshToken,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refresh_token": refreshToken,
    };
}
