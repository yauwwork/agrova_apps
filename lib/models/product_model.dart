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

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      userId: map["userId"] ?? "",
      name: map["name"] ?? "",
      category: map["category"] ?? "",
      price: map["price"] ?? 0,
      stock: map["stock"] ?? 0,
      description: map["description"] ?? "",
      location: map["location"] ?? "",
      imageBase64: map["imageBase64"] ?? "",
      createdAt: (map["createdAt"] as Timestamp?)?.toDate(),
    );
  }
}
