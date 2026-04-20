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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Favorit Saya",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
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
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
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
                    onChanged: (value) {
                      setState(() => searchQuery = value);
                    },
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(
                      hintText: "Cari produk favorit...",
                      hintStyle: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
                      prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// 🔥 KATEGORI
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          mainAxisSize: MainAxisSize.min,
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
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : itemColor,
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
                    style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 GRID PRODUK
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada produk favorit",
                          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                        ),
                      )
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
