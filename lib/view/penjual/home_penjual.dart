import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/card/produk_list_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {

  Widget buildStatCard(String title, String value, String percent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.softBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.softBlue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: "Inter",
                    color: AppColors.skyBlue,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  percent,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: "Inter",
                    color: AppColors.mintGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              "assets/images/gambarlain/download (1).jpg"),
                        ),

                        const SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Agrova",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: AppColors.oceanBlue,
                              ),
                            ),

                            Text(
                              "Nama Penjual",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Inter",
                                color: AppColors.oceanBlue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Amicons.remix_notification,
                        size: 25,
                        color: AppColors.oceanBlue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                /// PERFORMA TOKO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Performa Toko",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      "Dalam 30 hari",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    buildStatCard("Produk Dilihat", "150", "+15%"),
                    const SizedBox(width: 12),
                    buildStatCard("Produk Disukai", "50", "+10%"),
                  ],
                ),

                const SizedBox(height: 24),

                /// PRODUK ANDA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "Produk Anda",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 20,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProdukPenjual()),
                        );
                      },
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: AppColors.skyBlue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// LIST PRODUK
                Column(
                  children: daftarProduk.take(5).map((produk) {
                    return ListCard(
                      name: produk.nama,
                      category: produk.kategori,
                      price: produk.harga,
                      image: produk.image,
                      onEdit: () {
                        print("Edit ${produk.nama}");
                      },
                      onDelete: () {
                        setState(() {
                          daftarProduk.remove(produk);
                        });
                      },
                    );
                  }).toList(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}