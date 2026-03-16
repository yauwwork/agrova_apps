import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class FavoritSc extends StatefulWidget {
  const FavoritSc({super.key});

  @override
  State<FavoritSc> createState() => _FavoritScState();
}

class _FavoritScState extends State<FavoritSc> {
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
          "Produk Favorit",
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
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: favoritProduk.length,
                  itemBuilder: (context, index) {
                    final produk = favoritProduk[index];

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
