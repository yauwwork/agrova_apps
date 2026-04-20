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

    /// 🔥 FORCE userId dari Firebase Auth
    final newProduct = ProductModel(
      id: product.id,
      userId: user.uid, // ✅ FIX PENTING
      name: product.name,
      category: product.category,
      price: product.price,
      stock: product.stock,
      description: product.description,
      location: product.location,
      imageBase64: product.imageBase64,
      createdAt: product.createdAt,
    );

    await _firestore.collection("products").add(newProduct.toMap());
  }

  /// =====================
  /// GET ALL PRODUCTS
  /// =====================
  static Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection("products")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((e) {
            return ProductModel.fromMap(e.data(), e.id);
          }).toList();
        });
  }

  /// =====================
  /// GET MY PRODUCTS
  /// =====================
  static Stream<List<ProductModel>> getMyProducts() {
    final user = _auth.currentUser;

    if (user == null) {
      /// 🔥 HANDLE BIAR GAK ERROR
      return const Stream.empty();
    }

    return _firestore
        .collection("products")
        .where("userId", isEqualTo: user.uid)
        .orderBy("createdAt", descending: true) // ✅ biar rapi
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((e) {
            return ProductModel.fromMap(e.data(), e.id);
          }).toList();
        });
  }

  /// =====================
  /// UPDATE PRODUCT
  /// =====================
  static Future<void> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection("products").doc(id).update(data);
  }

  /// =====================
  /// DELETE PRODUCT
  /// =====================
  static Future<void> deleteProduct(String id) async {
    await _firestore.collection("products").doc(id).delete();
  }
}