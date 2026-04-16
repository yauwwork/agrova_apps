import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔥 HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 90),
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

            /// 🔥 STAT CARD (FIX OVERFLOW)
            Transform.translate(
              offset: const Offset(0, -60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
            ),

            /// 🔥 MENU (FIX OVERFLOW PAKAI EXPANDED)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Expanded(child: MenuCard(Icons.add, "Tambah", Colors.green)),
                  SizedBox(width: 10),
                  Expanded(
                    child: MenuCard(Icons.show_chart, "Analitik", Colors.blue),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MenuCard(Icons.inventory_2, "Produk", Colors.purple),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("Analitik", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🔥 LIST PRODUK (FIX OVERFLOW)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  TopProductCard(
                    1,
                    "assets/sample.jpg",
                    "Kopi Arabica Gayo",
                    "3200",
                    "204",
                    "4.9",
                  ),
                  TopProductCard(
                    2,
                    "assets/sample.jpg",
                    "Beras Premium Pandan Wangi",
                    "2450",
                    "89",
                    "4.8",
                  ),
                  TopProductCard(
                    3,
                    "assets/sample.jpg",
                    "Lada Hitam Lampung",
                    "2780",
                    "178",
                    "4.9",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
