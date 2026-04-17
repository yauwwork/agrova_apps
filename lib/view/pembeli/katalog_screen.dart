import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';

/// 🔥 MODEL KATEGORI (BIAR RAPI & ADA WARNA)
class KategoriModel {
  final String name; // nama kategori
  final IconData icon; // icon kategori
  final Color color; // warna utama kategori

  KategoriModel(this.name, this.icon, this.color);
}

class KategoriSc extends StatefulWidget {
  const KategoriSc({super.key});

  @override
  State<KategoriSc> createState() => _KategoriScState();
}

class _KategoriScState extends State<KategoriSc> {
  /// 🔥 INDEX KATEGORI YANG DIPILIH
  int selectedKategori = 0;

  /// 🔥 DATA KATEGORI + WARNA
  final List<KategoriModel> kategori = [
    KategoriModel("Semua", Icons.grid_view, Colors.green),
    KategoriModel("Pertanian", Icons.eco, Colors.green),
    KategoriModel("Perikanan", Icons.set_meal, Colors.blue),
    KategoriModel("Peternakan", Icons.grass, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,

      /// 🔥 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Katalog Produk",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// 🔍 SEARCH + FILTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  /// SEARCH BAR
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            "Cari produk...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// BUTTON FILTER
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffEAECEF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.tune, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🟢 LIST KATEGORI (BISA DI SCROLL)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: kategori.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedKategori == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedKategori = index; // ganti kategori aktif
                      });
                    },

                    /// 🔥 CHIP KATEGORI
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 200,
                      ), // animasi smooth
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        /// warna beda kalau dipilih
                        color: isSelected
                            ? kategori[index].color
                            : kategori[index].color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          /// ICON
                          Icon(
                            kategori[index].icon,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : kategori[index].color,
                          ),

                          const SizedBox(width: 6),

                          /// TEXT
                          Text(
                            kategori[index].name,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : kategori[index].color,
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

            const SizedBox(height: 16),

            /// 🔽 SORT + VIEW MODE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// SORT BUTTON
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffEAECEF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Text("Relevansi"),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),

                  /// TOGGLE GRID / LIST
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff2BB673),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAECEF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.list,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 📦 JUMLAH PRODUK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${daftarProduk.length} produk ditemukan",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 🧱 GRID PRODUK
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: daftarProduk.length,

                  /// GRID SETTING
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 kolom
                    crossAxisSpacing: 12, // jarak samping
                    mainAxisSpacing: 12, // jarak atas bawah
                    childAspectRatio: 0.72, // rasio card
                  ),

                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];

                    return GestureDetector(
                      onTap: () {
                        /// NAVIGATE KE DETAIL
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

                      /// 🔥 PAKE PRODUCT CARD LO
                      child: ProductCard(
                        title: produk.nama,
                        price: "Rp ${produk.harga}/kg",
                        image: produk.image,
                        seller: produk.penjual,
                        location: produk.lokasi,
                        rating: 4.5,

                        /// FAVORIT LOGIC
                        isFavorited: favoritProduk.contains(produk),
                        onFavorite: () {
                          setState(() {
                            if (favoritProduk.contains(produk)) {
                              favoritProduk.remove(produk);
                            } else {
                              favoritProduk.add(produk);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
