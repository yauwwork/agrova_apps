import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/view/penjual/edit_produk.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProdukPenjual extends StatefulWidget {
  const ProdukPenjual({super.key});

  @override
  State<ProdukPenjual> createState() => _ProdukPenjualState();
}

class _ProdukPenjualState extends State<ProdukPenjual> {
  int selectedKategori = 0;

  final user = FirebaseAuth.instance.currentUser;

  /// 🔥 SAMAIN DENGAN DATABASE
  final List<Map<String, dynamic>> kategori = [
    {"icon": Icons.all_inbox, "name": "Semua", "color": Colors.grey},
    {"icon": Icons.apple, "name": "Buah-buahan", "color": Colors.green},
    {"icon": Icons.grass, "name": "Sayuran", "color": Colors.lightGreen},
    {"icon": Icons.set_meal, "name": "Ikan", "color": Colors.blue},
    {"icon": Icons.lunch_dining, "name": "Daging", "color": Colors.red},
    {"icon": Icons.egg, "name": "Telur", "color": Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Produk Saya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔍 SEARCH
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Cari produk...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.skyBlue,
                  //     borderRadius: BorderRadius.circular(14),
                  //   ),
                  //   child: const Icon(Icons.tune, color: Colors.white),
                  // ),
                ],
              ),
            ),

            /// 🔥 KATEGORI
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: kategori.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedKategori == index;
                  final item = kategori[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedKategori = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? item["color"]
                            : item["color"].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item["icon"],
                            size: 16,
                            color: isSelected ? Colors.white : item["color"],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : item["color"],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// 🔥 GRID PRODUK (HANYA MILIK USER)
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: ProductService.getMyProducts(), // ✅ FIX UTAMA
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final allProducts = snapshot.data ?? [];

                  /// 🔥 FILTER KATEGORI
                  List<ProductModel> filtered = allProducts;

                  if (selectedKategori != 0) {
                    final selectedName = kategori[selectedKategori]["name"];

                    filtered = allProducts.where((p) {
                      return p.category.toLowerCase() ==
                          selectedName.toLowerCase();
                    }).toList();
                  }

                  if (filtered.isEmpty) {
                    return const Center(child: Text("Belum ada produk"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.68,
                        ),
                    itemBuilder: (context, index) {
                      final produk = filtered[index];

                      return SellerGridProductCard(
                        produk: produk,

                        /// 🔥 DELETE AMAN
                        onDelete: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Hapus Produk"),
                                ],
                              ),
                              content: const Text(
                                "Apakah Anda yakin ingin menghapus produk ini? Tindakan ini tidak dapat dibatalkan.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text(
                                    "Batal",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Hapus",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true && produk.id != null) {
                            await ProductService.deleteProduct(produk.id!);
                          }
                        },

                        /// 🔥 EDIT
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProduk(produk: produk),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
