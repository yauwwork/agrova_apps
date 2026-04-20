import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/product_model.dart';

/// =======================================================
/// 🔥 BASE STYLE
/// =======================================================
const double _radius = 16;
const double _imgRadius = 12;

/// =======================================================
/// 🔥 CATEGORY COLOR SYSTEM
/// =======================================================
Color getCategoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'buah-buahan':
    case 'buah':
      return Colors.orange;

    case 'sayur':
    case 'sayuran':
      return Colors.green;

    case 'ikan':
    case 'seafood':
      return Colors.blue;

    case 'daging':
      return Colors.red;

    case 'bumbu':
    case 'rempah':
      return Colors.brown;

    default:
      return Colors.grey;
  }
}

/// =======================================================
/// 🔥 LIST CARD (SELLER LIST)
/// =======================================================
class ListCard extends StatelessWidget {
  final ProductModel produk;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ListCard({super.key, required this.produk, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final categoryColor = getCategoryColor(produk.category);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(_imgRadius),
            child: produk.imageBase64.isNotEmpty
                ? Image.memory(
                    base64Decode(produk.imageBase64),
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 72,
                    height: 72,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_outlined),
                  ),
          ),

          const SizedBox(width: 12),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// CATEGORY TAG
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: categoryColor),
                  ),
                  child: Text(
                    produk.category,
                    style: TextStyle(
                      fontSize: 11,
                      color: categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Rp ${produk.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          /// ACTION
          Row(
            children: [
              _iconAction(Icons.edit, Colors.blue, onEdit),
              _iconAction(Icons.delete, Colors.red, onDelete),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconAction(IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

/// =======================================================
/// 🔥 MENU CARD
/// =======================================================
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const MenuCard(this.icon, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
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
/// 🔥 GRID CARD (SELLER)
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
    final categoryColor = getCategoryColor(produk.category);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(_radius),
                ),
                child: produk.imageBase64.isNotEmpty
                    ? Image.memory(
                        base64Decode(produk.imageBase64),
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(height: 120, color: Colors.grey.shade200),
              ),

              /// CATEGORY TAG (FIXED COLOR)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: categoryColor),
                  ),
                  child: Text(
                    produk.category,
                    style: TextStyle(
                      fontSize: 11,
                      color: categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              /// ACTION
              Positioned(
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    _smallAction(Icons.edit, Colors.blue, onEdit),
                    _smallAction(Icons.delete, Colors.red, onDelete),
                  ],
                ),
              ),
            ],
          ),

          /// CONTENT
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  produk.location,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                Text(
                  "Rp ${produk.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallAction(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
