import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SellerGridProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String image;
  final String location;
  final String views;
  final String favorites;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SellerGridProductCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.location,
    required this.views,
    required this.favorites,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          /// IMAGE + DELETE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(image),
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                Text(subtitle, style: TextStyle(fontSize: 12)),

                const SizedBox(height: 4),

                /// PRICE
                Text(
                  price,
                  style: const TextStyle(
                    color: AppColors.skyBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                /// STATS
                Row(
                  children: [
                    Icon(Icons.location_on, size: 13, color: Colors.grey[600]),
                    const SizedBox(width: 2),

                    Text(
                      location,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),

                    const Spacer(),

                    Icon(
                      Icons.remove_red_eye,
                      size: 13,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 2),

                    Text(
                      views,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),

                    const SizedBox(width: 6),

                    const Icon(Icons.favorite, size: 13, color: Colors.red),

                    const SizedBox(width: 2),

                    Text(
                      favorites,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.skyBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onEdit,
                    child: const Text(
                      "Edit Produk",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightSea,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
