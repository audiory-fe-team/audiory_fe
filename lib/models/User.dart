// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String userToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  AuthUser({
    this.id,
    required this.username,
    required this.email,
    required this.profilePhoto,
    required this.role,
  });

  String? id;
  String username;
  String email;
  String profilePhoto;
  String role;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        profilePhoto: json["profilePhoto"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "profilePhoto": profilePhoto,
        "role": role,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          email == other.email &&
          id == other.id;

  @override
  int get hashCode => username.hashCode ^ id.hashCode;
}
