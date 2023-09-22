// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final LoginResponse = LoginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  bool connexion;
  String jwtToken;
  int id;
  String username;
  String? password;

  LoginResponse(
      {required this.connexion,
      required this.jwtToken,
      required this.id,
      required this.username,
      this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'connexion': connexion,
      'jwtToken': jwtToken,
      'id': id,
      'username': username,
      'password': password
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
        connexion: map['connexion'] as bool,
        jwtToken: map['jwtToken'] as String,
        id: map['id'] as int,
        username: map['username'] as String,
        password: map['password'] as String?);
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  LoginResponse copyWith(
      {bool? connexion,
      String? jwtToken,
      int? id,
      String? username,
      String? password}) {
    return LoginResponse(
        connexion: connexion ?? this.connexion,
        jwtToken: jwtToken ?? this.jwtToken,
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
