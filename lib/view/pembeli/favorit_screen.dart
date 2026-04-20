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
    {"name": "Semua", "icon": Icons.apps, "color": Color(0xff22C55E)},
    {"name": "Pertanian", "icon": Icons.eco, "color": Color(0xffF59E0B)},
    {"name": "Perikanan", "icon": Icons.set_meal, "color": Color(0xff3B82F6)},
    {"name": "Peternakan", "icon": Icons.grass, "color": Color(0xffA16207)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Produk Favorit",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: StreamBuilder<List<ProductModel>>(
        stream: FavoriteService.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Gagal load favorit"));
          }

          final favoritProduk = snapshot.data ?? [];

          /// 🔥 FILTER SEARCH
          final filteredProduk = favoritProduk.where((produk) {
            return produk.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ================= SEARCH =================
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() => searchQuery = value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Cari produk favorit...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// ================= KATEGORI =================
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kategori.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedKategori == index;
                      final item = kategori[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedKategori = index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? item["color"] : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item["icon"],
                                size: 16,
                                color: isSelected
                                    ? Colors.white
                                    : item["color"],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item["name"],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
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

                /// ================= COUNT =================
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${filteredProduk.length} produk",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 10),

                /// ================= GRID =================
                Expanded(
                  child: filteredProduk.isEmpty
                      ? const Center(child: Text("Belum ada produk favorit"))
                      : GridView.builder(
                          itemCount: filteredProduk.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            final produk = filteredProduk[index];

                            return ProductCard(
                              produk: produk,
                              isFavorited: true,

                              /// 🔥 FIX: pakai product.id! (null safe)
                              onFavorite: (value) async {
                                if (produk.id == null) return;

                                await FavoriteService.removeFavorite(
                                    produk.id!);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}