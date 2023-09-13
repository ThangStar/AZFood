// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    int id;
    String username;
    String password;
    String name;
    String role;
    String phoneNumber;
    String email;

    Profile({
        required this.id,
        required this.username,
        required this.password,
        required this.name,
        required this.role,
        required this.phoneNumber,
        required this.email,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "name": name,
        "role": role,
        "phoneNumber": phoneNumber,
        "email": email,
    };
}
