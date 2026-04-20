import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String userId;
  final String name;
  final String category;
  final int price;
  final int stock;
  final String description;
  final String location;

  /// 🔥 FALLBACK (1 gambar lama)
  final String imageBase64;

  /// 🔥 MULTI IMAGE (baru)
  final List<String> images;

  final DateTime? createdAt;
  final int views;
  final int favorites;

  ProductModel({
    this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.location,
    required this.imageBase64,
    this.images = const [],
    this.createdAt,
    this.views = 0,
    this.favorites = 0,
  });

  /// =====================
  /// 🔥 TO MAP
  /// =====================
  Map<String, dynamic> toMap() {
    return {
      "userId": userId.trim(),
      "name": name.trim(),
      "category": category.trim(),
      "price": price,
      "stock": stock,
      "description": description.trim(),
      "location": location.trim(),
      "imageBase64": imageBase64,
      "views": views,
      "favorites": favorites,

      /// 🔥 SIMPAN MULTI IMAGE
      "images": images,

      "createdAt": FieldValue.serverTimestamp(),
    };
  }

  /// =====================
  /// 🔥 FROM MAP (ANTI ERROR)
  /// =====================
  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    List<String> imageList = [];

    /// 🔥 HANDLE SEMUA KEMUNGKINAN
    if (map["images"] != null && map["images"] is List) {
      imageList = List<String>.from(map["images"]);
    }

    return ProductModel(
      id: id,
      userId: map["userId"] ?? "",
      name: map["name"] ?? "",
      category: map["category"] ?? "",
      description: map["description"] ?? "",
      location: map["location"] ?? "",
      imageBase64: map["imageBase64"] ?? "",
      views: map["views"] ?? 0,
      favorites: map["favorites"] ?? 0,

      /// 🔥 FIX UTAMA DI SINI
      images: imageList,

      price: (map["price"] ?? 0) is int
          ? map["price"]
          : (map["price"] ?? 0).toInt(),

      stock: (map["stock"] ?? 0) is int
          ? map["stock"]
          : (map["stock"] ?? 0).toInt(),

      createdAt: map["createdAt"] != null
          ? (map["createdAt"] as Timestamp).toDate()
          : null,
    );
  }
}
