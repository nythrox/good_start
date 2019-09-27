import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String userId;
    String userEmail;
    Client client;

    UserModel({
        this.userId,
        this.userEmail,
        this.client,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userEmail: json["user_email"],
        client: Client.fromJson(json["client"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "client": client.toJson(),
    };
}

class Client {
    String clientId;
    String clientName;
    String clientCpf;
    DateTime clientBirthday;

    Client({
        this.clientId,
        this.clientName,
        this.clientCpf,
        this.clientBirthday,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        clientId: json["client_id"],
        clientName: json["client_name"],
        clientCpf: json["client_cpf"],
        clientBirthday: DateTime.parse(json["client_birthday"]),
    );

    Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "client_name": clientName,
        "client_cpf": clientCpf,
        "client_birthday": "${clientBirthday.year.toString().padLeft(4, '0')}-${clientBirthday.month.toString().padLeft(2, '0')}-${clientBirthday.day.toString().padLeft(2, '0')}",
    };
}
