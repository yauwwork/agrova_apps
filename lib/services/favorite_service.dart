import 'package:agrova_apps/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';

class FavoriteService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? get _userId => _auth.currentUser?.uid;

  /// =========================
  /// ❤️ TAMBAH FAVORIT
  /// =========================
  static Future<void> addFavorite(ProductModel product) async {
    if (product.id == null || _userId == null) return;

    await _db.collection('favorites').doc("${_userId}_${product.id}").set({
      "userId": _userId,
      "productId": product.id,
      "name": product.name,
      "price": product.price,
      "imageBase64": product.imageBase64,
      "location": product.location,
      "penjual": product.userId,
      "deskripsi": product.description,
      "category": product.category,
      "stock": product.stock,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await ProductService.updateFavoriteCount(product.id!, true);
  }

  /// =========================
  /// ❌ HAPUS FAVORIT
  /// =========================
  static Future<void> removeFavorite(String productId) async {
    if (_userId == null) return;

    await _db
        .collection('favorites')
        .doc("${_userId}_$productId")
        .delete();

    await ProductService.updateFavoriteCount(productId, false);
  }

  /// =========================
  /// ❤️ CEK FAVORIT REALTIME
  /// =========================
  static Stream<bool> isFavorited(String? productId) {
    if (productId == null || _userId == null) return Stream.value(false);

    return _db
        .collection('favorites')
        .doc("${_userId}_$productId")
        .snapshots()
        .map((doc) => doc.exists);
  }

  /// =========================
  /// 📦 GET FAVORIT LIST
  /// =========================
  static Stream<List<ProductModel>> getFavorites() {
    if (_userId == null) return Stream.value([]);

    return _db
        .collection('favorites')
        .where("userId", isEqualTo: _userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return ProductModel(
          id: data['productId'] ?? "",
          name: data['name'] ?? "",
          price: data['price'] ?? 0,
          imageBase64: data['imageBase64'] ?? "",
          location: data['location'] ?? "",
          userId: data['penjual'] ?? "",
          description: data['deskripsi'] ?? "",
          category: data['category'] ?? "",
          stock: data['stock'] ?? 0,
        );
      }).toList();
    });
  }
}