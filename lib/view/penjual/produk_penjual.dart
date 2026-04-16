import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/view/penjual/edit_produk.dart';
import 'package:amicons/amicons.dart';

class ProdukPenjual extends StatefulWidget {
  const ProdukPenjual({super.key});

  @override
  State<ProdukPenjual> createState() => _ProdukPenjualState();
}

class _ProdukPenjualState extends State<ProdukPenjual> {
  int selectedKategori = 0;

  final List<Map<String, dynamic>> kategori = [
    {"icon": Amicons.remix_plant, "name": "Pertanian", "color": Colors.green},
    {
      "icon": Amicons.flaticon_fish_rounded,
      "name": "Perikanan",
      "color": Colors.blue,
    },
    {
      "icon": Amicons.flaticon_cow_rounded,
      "name": "Peternakan",
      "color": Colors.brown,
    },
    {
      "icon": Amicons.lucide_tree_palm,
      "name": "Perkebunan",
      "color": Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Produk Saya",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// 🔍 SEARCH + FILTER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  /// SEARCH BAR
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30), // 🔥 rounded
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Cari produk...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// FILTER BUTTON
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.tune),
                  ),
                ],
              ),
            ),

            /// 🔥 KATEGORI (PILL BUTTON)
            SizedBox(
              height: 50,
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
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? item["color"] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item["icon"],
                            size: 16,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item["name"],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.w500,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: daftarProduk.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65, // 🔥 lebih proporsional
                  ),
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];

                    // return SellerGridProductCard(
                    //   title: produk.nama,
                    //   subtitle: produk.kategori,
                    //   price: "Rp ${produk.harga}",
                    //   image: produk.image,
                    //   location: produk.lokasi,
                    //   views: "0",
                    //   favorites: "0",

                    //   /// DELETE
                    //   onDelete: () {
                    //     setState(() {
                    //       daftarProduk.removeAt(index);
                    //     });
                    //   },

                    //   /// EDIT
                    //   onEdit: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) =>
                    //             EditProduk(produk: produk, index: index),
                    //       ),
                    //     ).then((_) => setState(() {}));
                    //   },
                    // );
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
