import 'dart:convert';
import 'package:agrova_apps/models/product_model.dart';
import 'package:flutter/material.dart';

/// =======================================================
/// 🔥 CATEGORY COLOR
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

    case 'pertanian':
      return Colors.teal;

    case 'perikanan':
      return Colors.indigo;

    default:
      return Colors.grey;
  }
}

/// =======================================================
/// 🔥 PRODUCT CARD
/// =======================================================
class ProductCard extends StatelessWidget {
  final ProductModel produk;
  final Function(bool)? onFavorite;
  final bool isFavorited;
  final VoidCallback? onTap; // 🔥 TAMBAHAN

  const ProductCard({
    super.key,
    required this.produk,
    this.onFavorite,
    this.isFavorited = false,
    this.onTap, // 🔥 TAMBAHAN
  });

  @override
  Widget build(BuildContext context) {
    final p = produk;
    final categoryColor = getCategoryColor(p.category);

    return GestureDetector(
      onTap: onTap, // 🔥 INI YANG BIKIN BISA DIKLIK
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= IMAGE =================
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: p.imageBase64.isNotEmpty
                      ? Image.memory(
                          const Base64Decoder().convert(p.imageBase64),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 120,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image),
                        ),
                ),

                /// gradient tipis
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                /// CATEGORY
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.category,
                      style: TextStyle(
                        fontSize: 10,
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                /// FAVORITE (AMAN, TIDAK IKUT KE TAP CARD)
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => onFavorite?.call(!isFavorited),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Rp ${p.price}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    p.description ?? "Produk segar langsung dari petani.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          p.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
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
