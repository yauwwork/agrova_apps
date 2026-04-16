import 'package:flutter/material.dart';

/// =======================================================
/// 🔥 STAT CARD (untuk dashboard angka)
/// =======================================================
class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatItem(this.icon, this.value, this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ICON BULAT
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),

        const SizedBox(height: 6),

        /// ANGKA
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),

        /// LABEL
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

/// =======================================================
/// 🔥 MENU CARD (Tambah Produk, Analitik, dll)
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

      /// BOX STYLE
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
        ],
      ),

      /// ISI CARD
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// ICON
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(height: 6),

          /// TITLE
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🔥 TOP PRODUCT CARD (produk terlaris)
/// =======================================================
class TopProductCard extends StatelessWidget {
  final int rank;
  final String image;
  final String title;
  final String views;
  final String likes;
  final String rating;

  const TopProductCard(
    this.rank,
    this.image,
    this.title,
    this.views,
    this.likes,
    this.rating, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),

      /// BOX STYLE
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          /// 🔥 RANK (1,2,3)
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.orange,
            child: Text("$rank", style: const TextStyle(color: Colors.white)),
          ),

          const SizedBox(width: 10),

          /// 🔥 GAMBAR PRODUK
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          ),

          const SizedBox(width: 10),

          /// 🔥 INFO PRODUK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAMA PRODUK
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                /// VIEW + LIKE
                Text(
                  "$views dilihat • ❤️ $likes",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          /// 🔥 RATING
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              Text(rating),
            ],
          ),
        ],
      ),
    );
  }
}
