// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:good_start/src/shared/models/user-model-hive.dart';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
    final String accessToken;
    final String refreshToken;
    final User user;

    AuthResponse({
        this.accessToken,
        this.refreshToken,
        this.user,
    });

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "user": user.toJson(),
    };
}
