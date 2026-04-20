import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/product_model.dart';

/// =======================================================
/// 🔥 BASE STYLE
/// =======================================================
const double _radius = 16;
const double _imgRadius = 12;

/// =======================================================
/// 🔥 CATEGORY COLOR SYSTEM (UPGRADED)
/// =======================================================
Color getCategoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'buah':
    case 'buah-buahan':
      return const Color(0xffFB923C);

    case 'sayur':
    case 'sayuran':
      return const Color(0xff22C55E);

    case 'ikan':
    case 'seafood':
      return const Color(0xff3B82F6);

    case 'daging':
      return const Color(0xffEF4444);

    case 'telur':
      return const Color(0xffFACC15);

    case 'bumbu':
    case 'rempah':
      return const Color(0xffA16207);

    default:
      return const Color(0xff6B7280);
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

    return GestureDetector(
      onTap: onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
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
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
            ),
            const SizedBox(width: 14),

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
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// garis aksen
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 2,
                    width: 30,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// CATEGORY
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      produk.category,
                      style: TextStyle(
                        fontSize: 10,
                        color: categoryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// PRICE
                  Row(
                    children: [
                      const Icon(Icons.sell, size: 14, color: Color(0xff22C55E)),
                      const SizedBox(width: 4),
                      Text(
                        "Rp ${produk.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff22C55E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// DELETE
            _iconAction(Icons.delete_outline_rounded, Colors.redAccent, onDelete),
          ],
        ),
      ),
    );
  }

  Widget _iconAction(IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: color),
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
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🔥 GRID CARD (SELLER) - PREMIUM VERSION
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

    return GestureDetector(
      onTap: onEdit,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE + EFFECT
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
                      : Container(
                          height: 120,
                          color: Colors.grey.shade100,
                          child: const Center(
                              child: Icon(Icons.image_outlined, color: Colors.grey)),
                        ),
                ),

                /// GRADIENT OVERLAY
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(_radius),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.25),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// CATEGORY TAG (COLOR BASED)
                Positioned(
                  top: 8,
                  left: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: categoryColor.withOpacity(0.85),
                        child: Text(
                          produk.category,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// DELETE BUTTON (SOFT STYLE)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onDelete,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete_rounded, size: 16, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),

                  /// aksen garis
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 2,
                    width: 30,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 10, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          produk.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.sell, size: 14, color: Color(0xff22C55E)),
                      const SizedBox(width: 4),
                      Text(
                        "Rp ${produk.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff22C55E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}