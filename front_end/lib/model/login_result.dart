// ignore_for_file: public_member_api_docs, sort_constructors_first
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


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'connexion': connexion,
      'jwtToken': jwtToken,
      'id': id,
      'username': username,
    };
  }

  factory LoginResult.fromMap(Map<String, dynamic> map) {
    return LoginResult(
      connexion: map['connexion'] as bool,
      jwtToken: map['jwtToken'] as String,
      id: map['id'] as int,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResult.fromJson(String source) => LoginResult.fromMap(json.decode(source) as Map<String, dynamic>);

  LoginResult copyWith({
    bool? connexion,
    String? jwtToken,
    int? id,
    String? username,
  }) {
    return LoginResult(
      connexion: connexion ?? this.connexion,
      jwtToken: jwtToken ?? this.jwtToken,
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }
}
