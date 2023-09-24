// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int id;
  String? username;
  String? password;
  String? name;
  String? role;
  String? phoneNumber;
  String? email;

  Profile({
    required this.id,
    this.username,
    this.password,
    this.name,
    this.role,
    this.phoneNumber,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as int,
      username: map['username'] as String?,
      password: map['password'] as String?,
      name: map['name'] as String?,
      role: map['role'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
    );
  }
}
