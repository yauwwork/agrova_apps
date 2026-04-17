import 'package:agrova_apps/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// =========================
  /// 🔥 REGISTER USER
  /// =========================
  static Future<UserModeFirebase> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user!;

      await user.updateDisplayName(username);

      final model = UserModeFirebase(
        uid: user.uid,
        email: email,
        username: username,
      );

      await _firestore.collection('users').doc(user.uid).set(model.toMap());

      return model;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e.code));
    }
  }

  /// =========================
  /// 🔥 LOGIN USER
  /// =========================
  static Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleLoginError(e.code));
    }
  }

  /// =========================
  /// 🔥 GET USER DATA
  /// =========================
  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    return doc.data();
  }

  /// =========================
  /// 🔥 ERROR HANDLER REGISTER
  /// =========================
  static String _handleAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "Email sudah digunakan";
      case 'invalid-email':
        return "Format email tidak valid";
      case 'weak-password':
        return "Password terlalu lemah";
      default:
        return "Terjadi kesalahan";
    }
  }

  /// =========================
  /// 🔥 ERROR HANDLER LOGIN
  /// =========================
  static String _handleLoginError(String code) {
    switch (code) {
      case 'user-not-found':
        return "Email tidak terdaftar";
      case 'wrong-password':
        return "Password salah";
      case 'invalid-email':
        return "Email tidak valid";
      default:
        return "Login gagal";
    }
  }
}
