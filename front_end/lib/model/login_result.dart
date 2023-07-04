// To parse this JSON data, do
//
//     final loginResult = loginResultFromJson(jsonString);

import 'dart:convert';

class LoginResult {
  bool connexion;
  String jwtToken;
  int id;
  String username;

  LoginResult({
    required this.connexion,
    required this.jwtToken,
    required this.id,
    required this.username,
  });

  factory LoginResult.fromRawJson(String str) =>
      LoginResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        connexion: json["connexion"],
        jwtToken: json["jwtToken"],
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "connexion": connexion,
        "jwtToken": jwtToken,
        "id": id,
        "username": username,
      };
}
