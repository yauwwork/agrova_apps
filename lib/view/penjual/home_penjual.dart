import 'dart:convert';

import 'package:agrova_apps/extension/card/stat_item_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/user_models.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:agrova_apps/view/penjual/analitik_screen.dart';
import 'package:agrova_apps/view/penjual/edit_produk.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:agrova_apps/view/penjual/profil_penjual.dart';
import 'package:agrova_apps/view/penjual/tambah_produk.dart';
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
              StreamBuilder<UserModeFirebase?>(
                stream: FirebaseService.userStream(user?.uid ?? ""),
                builder: (context, snapshot) {
                  final userData = snapshot.data;
                  final nama =
                      userData?.username ?? user?.displayName ?? "User";
                  final photoBase64 = userData?.photoBase64;

                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 50, 16, 110),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfilPenjualScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white24,
                            backgroundImage: photoBase64 != null
                                ? MemoryImage(base64Decode(photoBase64))
                                : (user?.photoURL != null
                                    ? NetworkImage(user!.photoURL!)
                                    : const AssetImage(
                                            "assets/images/gambarlain/download (1).jpg")
                                        as ImageProvider),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dashboard Penjual 🏪",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            Text(
                              nama,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              /// ================= STAT =================
              Positioned(
                bottom: -45,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder<List<ProductModel>>(
                    stream: ProductService.getMyProducts(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TambahProduk(),
                        ),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProdukPenjual(),
                        ),
                      );
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
                  "Produk Terbaru",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// ================= PRODUK =================
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: ProductService.getMyProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allMyProducts = snapshot.data ?? [];

                // Ambil hanya 10 produk terbaru (asumsi list sudah terurut dari service)
                final myProducts = allMyProducts.take(10).toList();

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
                      onDelete: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.red),
                                SizedBox(width: 10),
                                Text("Hapus Produk"),
                              ],
                            ),
                            content: const Text("Apakah Anda yakin ingin menghapus produk ini? Tindakan ini tidak dapat dibatalkan."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Hapus", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && p.id != null) {
                          await ProductService.deleteProduct(p.id!);
                        }
                      },
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProduk(produk: p),
                          ),
                        );
                      /// ✅ DELETE FIX
                      
                      }
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
