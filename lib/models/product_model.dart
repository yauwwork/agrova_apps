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
  final String imageBase64;
  final DateTime? createdAt;

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
    this.createdAt,
  });

  /// 🔥 TO MAP (SAVE KE FIRESTORE)
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "name": name,
      "category": category,
      "price": price,
      "stock": stock,
      "description": description,
      "location": location,
      "imageBase64": imageBase64,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  /// 🔥 FROM MAP (AMBIL DARI FIRESTORE)
  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,

      /// SAFE STRING
      userId: map["userId"] ?? "",
      name: map["name"] ?? "",
      category: map["category"] ?? "",
      description: map["description"] ?? "",
      location: map["location"] ?? "",
      imageBase64: map["imageBase64"] ?? "",

      /// 🔥 SAFE INT (ANTI ERROR DOUBLE)
      price: (map["price"] ?? 0) is int
          ? map["price"]
          : (map["price"] ?? 0).toInt(),

      stock: (map["stock"] ?? 0) is int
          ? map["stock"]
          : (map["stock"] ?? 0).toInt(),

      /// 🔥 SAFE DATE
      createdAt: map["createdAt"] != null
          ? (map["createdAt"] as Timestamp).toDate()
          : null,
    );
  }
}