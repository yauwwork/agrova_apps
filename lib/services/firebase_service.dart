import 'package:agrova_apps/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// =========================
  /// 🔥 CREATE / REGISTER USER
  /// =========================
  static Future<UserModeFirebase> registerUser({
    required String email,
    required String password,
    required String username,
    String role = 'pembeli',
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
        role: role,
      );

      await _firestore.collection('users').doc(user.uid).set(model.toMap());
      return model;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e.code));
    }
  }

  /// =========================
  /// 🔥 READ / LOGIN USER
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
  /// 🔥 READ / GET USER DATA
  /// =========================
  static Future<UserModeFirebase?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModeFirebase.fromMap(doc.data()!);
    }
    return null;
  }

  /// STREAM FOR REALTIME DATA
  static Stream<UserModeFirebase?> userStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModeFirebase.fromMap(doc.data()!);
      }
      return null;
    });
  }

  /// =========================
  /// 🔥 UPDATE USER DATA (CRUD)
  /// =========================
  static Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      // Gunakan set dengan merge agar jika dokumen belum ada, dia akan membuat baru
      await _firestore.collection('users').doc(uid).set(
            data,
            SetOptions(merge: true),
          );

      // If updating username, also update Auth Profile
      if (data.containsKey('username')) {
        await _auth.currentUser?.updateDisplayName(data['username']);
      }
      
      // If updating photoUrl, also update Auth Profile
      if (data.containsKey('photoUrl')) {
        await _auth.currentUser?.updatePhotoURL(data['photoUrl']);
      }
    } catch (e) {
      throw Exception("Gagal update data: $e");
    }
  }

  /// UPDATE PROFILE PHOTO (BASE64)
  static Future<void> updateProfilePhoto(String base64) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User tidak ditemukan");

    await updateUserData(uid, {'photoBase64': base64});
  }

  /// =========================
  /// 🔥 DELETE USER DATA (CRUD)
  /// =========================
  static Future<void> deleteUserAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final uid = user.uid;

      // 1. Hapus data di Firestore
      await _firestore.collection('users').doc(uid).delete();

      // 2. Hapus data di Auth (Membutuhkan re-login jika sesi sudah lama)
      await user.delete();
    } catch (e) {
      throw Exception("Gagal menghapus akun: $e");
    }
  }

  /// =========================
  /// 🔥 LOGOUT
  /// =========================
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// =========================
  /// 🔥 ERROR HANDLERS
  /// =========================
  static String _handleAuthError(String code) {
    switch (code) {
      case 'email-already-in-use': return "Email sudah digunakan";
      case 'invalid-email': return "Format email tidak valid";
      case 'weak-password': return "Password terlalu lemah";
      default: return "Terjadi kesalahan";
    }
  }

  static String _handleLoginError(String code) {
    switch (code) {
      case 'user-not-found': return "Email tidak terdaftar";
      case 'wrong-password': return "Password salah";
      case 'invalid-email': return "Email tidak valid";
      default: return "Login gagal";
    }
  }
}
