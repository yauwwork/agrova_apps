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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Produk Saya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
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
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: isDark ? Colors.white60 : Colors.grey),
                          hintText: "Cari produk...",
                          hintStyle: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
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
                  final itemColor = item["color"] as Color;

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
                            ? itemColor
                            : itemColor.withOpacity(isDark ? 0.2 : 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected 
                            ? null 
                            : Border.all(color: itemColor.withOpacity(isDark ? 0.3 : 0.1)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item["icon"],
                            size: 16,
                            color: isSelected ? Colors.white : itemColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : itemColor,
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

            /// 🔥 GRID PRODUK
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: ProductService.getMyProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)));
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
                    return Center(child: Text("Belum ada produk", style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)));
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
                        onDelete: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              backgroundColor: theme.cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Text("Hapus Produk", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                                ],
                              ),
                              content: Text(
                                "Apakah Anda yakin ingin menghapus produk ini? Tindakan ini tidak dapat dibatalkan.",
                                style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
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
