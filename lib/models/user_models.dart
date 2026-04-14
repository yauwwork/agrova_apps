// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModeFirebase {
  final String? uid;
  final String email;
  final String password;
  final String username;

  UserModeFirebase({
    required this.uid,
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
      'username': username,
    };
  }

  factory UserModeFirebase.fromMap(Map<String, dynamic> map) {
    return UserModeFirebase(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModeFirebase.fromJson(String source) =>
      UserModeFirebase.fromMap(json.decode(source) as Map<String, dynamic>);
}
