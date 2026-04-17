import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:flutter/material.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  int selectedKategori = 0;

  /// 🔥 KATEGORI + WARNA + ICON (biar ga flat)
  final List<Map<String, dynamic>> kategori = [
    {"name": "Semua", "icon": Icons.apps, "color": Color(0xff22C55E)},
    {"name": "Pertanian", "icon": Icons.eco, "color": Color(0xffF59E0B)},
    {"name": "Perikanan", "icon": Icons.set_meal, "color": Color(0xff3B82F6)},
    {"name": "Peternakan", "icon": Icons.grass, "color": Color(0xffA16207)},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredProduk = favoritProduk.where((produk) {
      return produk.nama.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 SEARCH BAR PREMIUM
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Cari produk favorit...",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.search, size: 22),
                  suffixIcon: Icon(Icons.tune, color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// 🔥 KATEGORI BUTTON (SCROLL + ELEVATED STYLE)
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
                      setState(() {
                        selectedKategori = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? item["color"] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: item["color"].withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                        border: Border.all(
                          color: isSelected
                              ? item["color"]
                              : Colors.grey.shade300,
                        ),
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
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            /// JUMLAH PRODUK
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${filteredProduk.length} produk",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            const SizedBox(height: 10),

            /// GRID
            Expanded(
              child: filteredProduk.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada produk favorit",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
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

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailProdukSc(
                                  title: produk.nama,
                                  price: "Rp ${produk.harga}/kg",
                                  image: produk.image,
                                  penjual: produk.penjual,
                                  location: produk.lokasi,
                                  deskripsi: produk.deskripsi,
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            title: produk.nama,
                            price: "Rp ${produk.harga}/kg",
                            image: produk.image,
                            seller: produk.penjual,
                            location: produk.lokasi,
                            rating: 4.5,
                            isFavorited: true,
                            onFavorite: () {
                              setState(() {
                                favoritProduk.remove(produk);
                              });
                            },
                          ),
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
