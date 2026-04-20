import 'package:agrova_apps/extension/card/stat_item_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/analitik_screen.dart';
import 'package:flutter/material.dart';

import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/extension/card/penjual_produk_card.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 80),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.skyBlue, AppColors.mintGreen],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dashboard Penjual 🏪",
                              style: TextStyle(color: Colors.white70)),
                          Text(
                            "Andi Wijaya",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -40,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        StatItem(Icons.inventory, "12", "Produk",
                            AppColors.mintGreen),
                        StatItem(Icons.remove_red_eye, "15.7k", "Dilihat",
                            AppColors.skyBlue),
                        StatItem(Icons.favorite, "892", "Favorit", Colors.pink),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            /// ================= MENU =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: MenuCard(Icons.add, "Tambah", AppColors.mintGreen),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnalitikScreen(),
                          ),
                        );
                      },
                      child: const MenuCard(
                          Icons.show_chart, "Analitik", AppColors.skyBlue),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: MenuCard(
                        Icons.inventory_2, "Produk", AppColors.secondary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= TITLE =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Produk Saya",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// ================= 🔥 PRODUK FIREBASE =================
            StreamBuilder<List<ProductModel>>(
              stream: ProductService.getMyProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Belum ada produk"),
                  );
                }

                final products = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final p = products[index];

                    return SellerGridProductCard(
                      produk: p,
                      onEdit: () {
                        /// nanti arah ke edit screen
                      },
                      onDelete: () async {
                        await ProductService.deleteProduct(p.id!);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}