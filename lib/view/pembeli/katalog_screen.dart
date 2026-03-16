import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class KategoriSc extends StatefulWidget {
  const KategoriSc({super.key});

  @override
  State<KategoriSc> createState() => _KategoriScState();
}

class _KategoriScState extends State<KategoriSc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.softMint,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.leafGreen,
          ),
        ),
        title: Text(
          "Katalog Produk",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 360,
                      decoration: BoxDecoration(
                        color: AppColors.softMint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Cari Produk",
                          prefixIcon: Icon(
                            Amicons.remix_search,
                            color: AppColors.leafGreen,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Amicons.iconly_category,
                        size: 18,
                      ), // icon di kiri
                      label: Text(
                        "Kategori",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.mintGreen, // warna background
                        foregroundColor: Colors.white, // warna text & icon
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.list, size: 18), // icon di kiri
                      label: Text(
                        "Urutkan",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.mintGreen, // warna background
                        foregroundColor: Colors.white, // warna text & icon
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Amicons.remix_filter3,
                        size: 18,
                      ), // icon di kiri
                      label: Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.mintGreen, // warna background
                        foregroundColor: Colors.white, // warna text & icon
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: daftarProduk.length,
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProdukSc(
                              title: produk.nama,
                              price: "Rp ${produk.harga}/Kg",
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
                        price: "Rp ${produk.harga}/Kg",
                        image: produk.image,
                        seller: produk.penjual,
                        location: produk.lokasi,
                        rating: 5.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
