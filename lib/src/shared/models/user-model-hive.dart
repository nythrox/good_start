
import 'dart:convert';
import 'package:hive/hive.dart';

part 'user-model-hive.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@HiveType()
class User extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;
  
  @HiveField(2)
  String email;

  @HiveField(3)
  String role;



    User({
        this.name,
        this.id,
        this.email,
        this.role,
    });


    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["username"],
        id: json["id"],
        email: json["email"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "username": name,
        "id": id,
        "email": email,
        "role": role,
    };
}
