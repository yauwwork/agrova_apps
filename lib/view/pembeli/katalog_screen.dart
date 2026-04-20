import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/services/favorite_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';

class KategoriModel {
  final String name;
  final IconData icon;
  final Color color;

  KategoriModel(this.name, this.icon, this.color);
}

class KategoriSc extends StatefulWidget {
  const KategoriSc({super.key});

  @override
  State<KategoriSc> createState() => _KategoriScState();
}

class _KategoriScState extends State<KategoriSc> {
  int selectedKategori = 0;

  final List<KategoriModel> kategori = [
    KategoriModel("Semua", Icons.all_inbox, Colors.grey),
    KategoriModel("Buah-buahan", Icons.apple, Colors.green),
    KategoriModel("Sayuran", Icons.grass, Colors.lightGreen),
    KategoriModel("Ikan", Icons.set_meal, Colors.blue),
    KategoriModel("Daging", Icons.lunch_dining, Colors.red),
    KategoriModel("Telur", Icons.egg, Colors.orange),
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
        title: Text(
          "Katalog Produk",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔍 SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: isDark ? Colors.white60 : Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            "Cari produk...",
                            style: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: isDark ? theme.cardColor : const Color(0xffEAECEF),
                      borderRadius: BorderRadius.circular(16),
                      border: isDark ? Border.all(color: Colors.white12) : null,
                    ),
                    child: Icon(Icons.tune, color: isDark ? Colors.white70 : Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔥 KATEGORI
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: kategori.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedKategori == index;
                  final itemColor = kategori[index].color;

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
                            kategori[index].icon,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : itemColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            kategori[index].name,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : itemColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// 🔥 PRODUK
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: ProductService.getProducts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allProducts = snapshot.data!;

                  /// FILTER
                  List<ProductModel> filtered = allProducts;

                  if (selectedKategori != 0) {
                    final selectedName = kategori[selectedKategori].name
                        .toLowerCase()
                        .trim();

                    filtered = allProducts.where((p) {
                      return p.category.toLowerCase().trim() == selectedName;
                    }).toList();
                  }

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        "Produk tidak ada",
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      ),
                    );
                  }

                  return GridView.builder(
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

                      return StreamBuilder<bool>(
                        stream: FavoriteService.isFavorited(produk.id),
                        builder: (context, favSnap) {
                          final isFav = favSnap.data ?? false;

                          return ProductCard(
                            produk: produk,
                            isFavorited: isFav,
                            onFavorite: (value) async {
                              if (produk.id == null) return;

                              if (value) {
                                await FavoriteService.addFavorite(produk);
                              } else {
                                await FavoriteService.removeFavorite(
                                  produk.id!,
                                );
                              }
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailProdukSc(product: produk),
                                ),
                              );
                            },
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
