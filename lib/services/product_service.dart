import 'package:agrova_apps/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  /// =====================
  /// CREATE PRODUCT
  /// =====================
  static Future<void> addProduct(ProductModel product) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final data = product.toMap();

    /// 🔥 FORCE USER ID (WAJIB)
    data["userId"] = user.uid;

    /// 🔥 ANTI NULL
    data.removeWhere((key, value) => value == null);

    await _firestore.collection("products").add(data);
  }

  /// =====================
  /// GET ALL PRODUCTS (UNTUK PEMBELI)
  /// =====================
  static Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection("products")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((e) => ProductModel.fromMap(e.data(), e.id))
              .toList();
        });
  }

  /// =====================
  /// GET MY PRODUCTS (KHUSUS PENJUAL)
  /// =====================
  static Stream<List<ProductModel>> getMyProducts() {
    final user = _auth.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("products")
        .where("userId", isEqualTo: user.uid)
        .orderBy("createdAt", descending: true) // 🔥 WAJIB BUAT RAPI
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((e) => ProductModel.fromMap(e.data(), e.id))
              .toList();
        });
  }

  /// =====================
  /// UPDATE PRODUCT (AMAN)
  /// =====================
  static Future<void> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final doc = await _firestore.collection("products").doc(id).get();

    if (!doc.exists) {
      throw Exception("Produk tidak ditemukan");
    }

    /// 🔥 CEK OWNER
    if (doc["userId"] != user.uid) {
      throw Exception("Tidak punya akses");
    }

    data.removeWhere((key, value) => value == null);

    await _firestore.collection("products").doc(id).update(data);
  }

  /// =====================
  /// DELETE PRODUCT (AMAN)
  /// =====================
  static Future<void> deleteProduct(String id) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final doc = await _firestore.collection("products").doc(id).get();

    if (!doc.exists) {
      throw Exception("Produk tidak ditemukan");
    }

    /// 🔥 CEK OWNER
    if (doc["userId"] != user.uid) {
      throw Exception("Tidak punya akses");
    }

    await _firestore.collection("products").doc(id).delete();
  }
}
