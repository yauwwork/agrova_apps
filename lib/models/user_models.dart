class UserModeFirebase {
  final String? uid;
  final String email;
  final String username;

  UserModeFirebase({
    required this.uid,
    required this.email,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'username': username};
  }

  factory UserModeFirebase.fromMap(Map<String, dynamic> map) {
    return UserModeFirebase(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
    );
  }
}
