import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/services/product_service.dart';
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
    KategoriModel("Semua", Icons.grid_view, Colors.green),
    KategoriModel("Pertanian", Icons.eco, Colors.green),
    KategoriModel("Perikanan", Icons.set_meal, Colors.blue),
    KategoriModel("Peternakan", Icons.grass, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,
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
            /// SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
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
                          Text("Cari produk...",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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

            /// KATEGORI CHIP
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
                        selectedKategori = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? kategori[index].color
                            : kategori[index].color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            kategori[index].icon,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : kategori[index].color,
                          ),
                          const SizedBox(width: 6),
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

            /// SORT UI (tetap)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff2BB673),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.grid_view,
                            size: 18, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAECEF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.list,
                            size: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🔥 PRODUK FIREBASE
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: ProductService.getProducts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allProducts = snapshot.data!;

                  /// 🔥 FILTER KATEGORI
                  List<ProductModel> filtered = allProducts;

                  if (selectedKategori != 0) {
                    final selectedName =
                        kategori[selectedKategori].name;

                    filtered = allProducts.where((p) {
                      return p.category
                          .toLowerCase()
                          .contains(selectedName.toLowerCase());
                    }).toList();
                  }

                  if (filtered.isEmpty) {
                    return const Center(child: Text("Produk tidak ada"));
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

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailProdukSc(
                                title: produk.name,
                                price: "Rp ${produk.price}",
                                imageBase64: produk.imageBase64,
                                penjual: produk.userId,
                                location: produk.location,
                                deskripsi: produk.description,
                              ),
                            ),
                          );
                        },

                        /// 🔥 CARD AKTIF
                        child: ProductCard(produk: produk),
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