import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
import 'package:agrova_apps/extension/card/penjual_produk_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/models/produk_models.dart';
import 'package:agrova_apps/view/penjual/edit_produk.dart';
import 'dart:io';

class ProdukPenjual extends StatefulWidget {
  const ProdukPenjual({super.key});

  @override
  State<ProdukPenjual> createState() => _ProdukPenjualState();
}

class _ProdukPenjualState extends State<ProdukPenjual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bgpenjual,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePenjualSc()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.skyBlue,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Produk Saya",
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
                        color: AppColors.skyBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Cari Produk",
                          prefixIcon: Icon(
                            Amicons.remix_search,
                            color: AppColors.skyBlue,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MenuKategori(
                        Amicons.remix_plant,
                        "Pertanian",
                        AppColors.leafGreen,
                        AppColors.mintGreen.withOpacity(0.2),
                      ),
                      SizedBox(width: 20),

                      MenuKategori(
                        Amicons.flaticon_fish_rounded,
                        "Perikanan",
                        AppColors.darkOceanBlue,
                        AppColors.oceanBlue.withOpacity(0.2),
                      ),
                      SizedBox(width: 20),

                      MenuKategori(
                        Amicons.flaticon_cow_rounded,
                        "Peternakan",
                        Colors.brown,
                        Colors.brown.withOpacity(0.2),
                      ),
                      SizedBox(width: 20),

                      MenuKategori(
                        Amicons.lucide_tree_palm,
                        "Perkebunan",
                        AppColors.darkLeafGreen,
                        AppColors.leafGreen.withOpacity(0.2),
                      ),
                      SizedBox(width: 20),

                      MenuKategori(
                        Amicons.lucide_tree_palm,
                        "Perkebunan",
                        AppColors.darkLeafGreen,
                        AppColors.leafGreen.withOpacity(0.2),
                      ),
                      SizedBox(width: 20),

                      MenuKategori(
                        Amicons.lucide_tree_palm,
                        "Perkebunan",
                        AppColors.darkLeafGreen,
                        AppColors.leafGreen.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28),

                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: daftarProduk.length,
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];

                    return SellerGridProductCard(
                      title: produk.nama,
                      subtitle: produk.kategori,
                      price: "Rp ${produk.harga}",
                      image: produk.image,
                      location: produk.lokasi,
                      views: "0",
                      favorites: "0",

                      onDelete: () {
                        setState(() {
                          daftarProduk.removeAt(index);
                        });
                      },

                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditProduk(produk: produk, index: index),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
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

  Widget MenuKategori(
    IconData icon,
    String title,
    Color iconColor,
    Color bgColor,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon, color: iconColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
