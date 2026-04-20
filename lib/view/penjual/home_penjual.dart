import 'package:agrova_apps/extension/card/stat_item_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/analitik_screen.dart';
import 'package:agrova_apps/view/penjual/edit_produk.dart';
import 'package:flutter/material.dart';

import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,

      body: Column(
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
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dashboard Penjual 🏪",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          user?.displayName ?? "User",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ),

              /// ================= STAT =================
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
                  child: StreamBuilder<List<ProductModel>>(
                    stream: ProductService.getMyProducts(), // ✅ FIX
                    builder: (context, snapshot) {
                      final myProducts = snapshot.data ?? [];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StatItem(
                            Icons.inventory,
                            "${myProducts.length}",
                            "Produk",
                            AppColors.mintGreen,
                          ),
                          const StatItem(
                            Icons.remove_red_eye,
                            "15.7k",
                            "Dilihat",
                            AppColors.skyBlue,
                          ),
                          const StatItem(
                            Icons.favorite,
                            "892",
                            "Favorit",
                            Colors.pink,
                          ),
                        ],
                      );
                    },
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
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // TODO: Tambah produk
                    },
                    child: const MenuCard(
                      Icons.add,
                      "Tambah",
                      AppColors.mintGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalitikScreen(),
                        ),
                      );
                    },
                    child: const MenuCard(
                      Icons.show_chart,
                      "Analitik",
                      AppColors.skyBlue,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // optional
                    },
                    child: const MenuCard(
                      Icons.inventory_2,
                      "Produk",
                      AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= TITLE =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "Produk Saya",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// ================= PRODUK =================
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: ProductService.getMyProducts(), // ✅ FIX WAJIB
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final myProducts = snapshot.data ?? [];

                if (myProducts.isEmpty) {
                  return const Center(child: Text("Belum ada produk"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: myProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final p = myProducts[index];

                    return SellerGridProductCard(
                      produk: p,

                      /// ✅ EDIT FIX
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProduk(produk: p),
                          ),
                        );
                      },

                      /// ✅ DELETE FIX
                      onDelete: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Hapus Produk"),
                            content: const Text("Yakin mau hapus produk ini?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Batal"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Hapus"),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && p.id != null) {
                          await ProductService.deleteProduct(p.id!);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
