class UserModeFirebase {
  final String? uid;
  final String email;
  final String username;
  final String? photoUrl;
  final String? photoBase64;
  final String? role; // pembeli atau penjual

  UserModeFirebase({
    required this.uid,
    required this.email,
    required this.username,
    this.photoUrl,
    this.photoBase64,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
      'photoBase64': photoBase64,
      'role': role,
    };
  }

  factory UserModeFirebase.fromMap(Map<String, dynamic> map) {
    return UserModeFirebase(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      photoBase64: map['photoBase64'],
      role: map['role'],
    );
  }
}
