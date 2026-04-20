import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/services/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  int selectedKategori = 0;
  String searchQuery = "";

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
      backgroundColor: AppColors.softMint,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Favorit Saya",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: StreamBuilder<List<ProductModel>>(
        stream: FavoriteService.getFavorites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allProduk = snapshot.data!;

          /// 🔍 FILTER SEARCH
          List<ProductModel> filtered = allProduk.where((produk) {
            return produk.name.toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
          }).toList();

          /// 🔥 FILTER KATEGORI
          if (selectedKategori != 0) {
            final selectedName = kategori[selectedKategori]["name"];

            filtered = filtered.where((p) {
              return p.category.toLowerCase() == selectedName.toLowerCase();
            }).toList();
          }

          return Column(
            children: [
              const SizedBox(height: 10),

              /// 🔍 SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() => searchQuery = value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Cari produk favorit...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// 🔥 KATEGORI (FIX FINAL STYLE - CLEAN KAYAK KATALOG)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          mainAxisSize: MainAxisSize.min,
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
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : item["color"],
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

              /// 🔢 COUNT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${filtered.length} produk favorit",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 GRID PRODUK
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text("Belum ada produk favorit"))
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filtered.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final produk = filtered[index];

                          return ProductCard(
                            produk: produk,
                            isFavorited: true,
                            onFavorite: (value) async {
                              if (produk.id == null) return;

                              await FavoriteService.removeFavorite(produk.id!);
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
