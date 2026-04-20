import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/product_model.dart';

/// =======================================================
/// 🔥 LIST CARD (SELLER LIST)
/// dipakai buat list vertical produk penjual
/// =======================================================
class ListCard extends StatelessWidget {
  final ProductModel produk;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ListCard({super.key, required this.produk, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔥 IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: produk.imageBase64.isNotEmpty
                ? Image.memory(
                    base64Decode(produk.imageBase64),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
          ),

          const SizedBox(width: 16),

          /// 🔥 CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  produk.category,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),

                const SizedBox(height: 6),

                Text(
                  "Rp ${produk.price}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 ACTION BUTTON
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🔥 MENU CARD (DARI HOME PENJUAL)
/// buat tombol: Tambah, Analitik, Produk
/// =======================================================
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const MenuCard(this.icon, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🔥 ICON BOX
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 8),

          /// 🔥 TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🔥 SELLER GRID PRODUCT CARD
/// ini yang dipakai di HomePenjual (grid produk)
/// =======================================================
class SellerGridProductCard extends StatelessWidget {
  final ProductModel produk;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SellerGridProductCard({
    super.key,
    required this.produk,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 6),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 IMAGE + ACTION
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: produk.imageBase64.isNotEmpty
                    ? Image.memory(
                        base64Decode(produk.imageBase64),
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 110,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
              ),

              /// 🔥 KATEGORI
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(produk.category),
                ),
              ),

              /// 🔥 EDIT + DELETE
              Positioned(
                top: 6,
                right: 6,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 16,
                      ),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 16,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// 🔥 CONTENT
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(produk.name),
                Text(produk.location),
                Text("Rp ${produk.price}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}