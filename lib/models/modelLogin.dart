// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
    String status;
    String idUser;
    String username;
    String password;
    String level;
    String nama;
    String noKtp;
    String noTelp;

    ModelLogin({
        this.status,
        this.idUser,
        this.username,
        this.password,
        this.level,
        this.nama,
        this.noKtp,
        this.noTelp,
    });

    factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        status: json["status"],
        idUser: json["id_user"],
        username: json["username"],
        password: json["password"],
        level: json["level"],
        nama: json["nama"],
        noKtp: json["no_ktp"],
        noTelp: json["no_telp"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "id_user": idUser,
        "username": username,
        "password": password,
        "level": level,
        "nama": nama,
        "no_ktp": noKtp,
        "no_telp": noTelp,
    };
}
