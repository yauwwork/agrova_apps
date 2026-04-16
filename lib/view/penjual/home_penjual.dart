import 'package:flutter/material.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      /// 🔥 PAKAI STACK BIAR HEADER + STAT CARD MENYATU
      body: Stack(
        children: [
          /// =========================
          /// 🔥 MAIN CONTENT
          /// =========================
          SingleChildScrollView(
            child: Column(
              children: [
                /// 🔥 HEADER (GRADIENT)
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 100),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff3B82F6), Color(0xff22C55E)],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      const SizedBox(width: 10),

                      /// NAMA USER
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Dashboard Penjual 🏪",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Andi Wijaya",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                ),

                /// 🔥 SPACE BUAT STAT CARD (PENTING!)
                const SizedBox(height: 60),

                /// 🔥 MENU
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Expanded(
                        child: MenuCard(Icons.add, "Tambah", Colors.green),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MenuCard(
                          Icons.show_chart,
                          "Analitik",
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MenuCard(
                          Icons.inventory_2,
                          "Produk",
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔥 TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Produk Terlaris",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Analitik", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// 🔥 LIST PRODUK
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: const [
                      // 👉 nanti isi TopProductCard di sini
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),

          /// =========================
          /// 🔥 STAT CARD (FLOATING)
          /// =========================
          Positioned(
            top: 140, // 🔥 posisi nempel ke header
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black.withOpacity(0.06),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  StatItem(Icons.inventory, "12", "Produk", Colors.green),
                  StatItem(
                    Icons.remove_red_eye,
                    "15.7k",
                    "Dilihat",
                    Colors.blue,
                  ),
                  StatItem(Icons.favorite, "892", "Favorit", Colors.pink),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================
/// 🔥 STAT ITEM
/// =========================
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
        Icon(icon, color: color),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

/// =========================
/// 🔥 MENU CARD
/// =========================
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const MenuCard(this.icon, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(title),
        ],
      ),
    );
  }
}

/// =========================
/// 🔥 TOP PRODUCT CARD
/// =========================
class TopProductCard extends StatelessWidget {
  final int rank;
  final String image;
  final String title;
  final String sold;
  final String views;
  final String rating;

  const TopProductCard(
    this.rank,
    this.image,
    this.title,
    this.sold,
    this.views,
    this.rating, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text("#$rank", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(
                  "$sold terjual",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Column(
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
