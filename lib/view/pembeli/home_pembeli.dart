import 'dart:async';

import 'package:agrova_apps/extension/card/produk_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePembeli extends StatefulWidget {
  const HomePembeli({super.key});

  @override
  State<HomePembeli> createState() => _HomePembeli();
}

class _HomePembeli extends State<HomePembeli> {
  final PageController _pageController = PageController();

  int currentBanner = 0;

  final List bannerList = [
    ["Promo Panen Raya", "Diskon 50%"],
    ["Gratis Ongkir", "SeIndonesia"],
    ["Harga Ikan", "Turun"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 20),

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Selamat Pagi"),
                        Text(
                          "Agrova",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    const Icon(Icons.notifications_none),
                  ],
                ),

                const SizedBox(height: 20),

                /// SEARCH
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari produk",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BANNER SLIDER
                SizedBox(
                  height: 140,

                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: bannerList.length,

                    onPageChanged: (index) {
                      setState(() {
                        currentBanner = index;
                      });
                    },

                    itemBuilder: (context, index) {
                      final banner = bannerList[index];

                      return BannerItem(banner[0], banner[1]);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                /// SMOOTH INDICATOR
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: bannerList.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// KATEGORI
                const Text(
                  "Kategori",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: [
                      categoryItem(Icons.eco, "Pertanian"),
                      categoryItem(Icons.set_meal, "Perikanan"),
                      categoryItem(Icons.pets, "Peternakan"),
                      categoryItem(Icons.forest, "Perkebunan"),
                      categoryItem(Icons.spa, "Organik"),
                      categoryItem(Icons.local_florist, "Sayuran"),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// PRODUK
                const Text(
                  "Produk Populer",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: 6,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),

                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: "Brokoli Ngawi",
                      price: "Rp 25.000",
                      image: "assets/images/gambarlain/🥦.jpg",
                      seller: "Pak Yanto",
                      location: "Bantul",
                      rating: 4.8,
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BannerItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(right: 10),

      decoration: BoxDecoration(
        color: AppColors.leafGreen,
        borderRadius: BorderRadius.circular(16),
      ),

      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(title, style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// CATEGORY ITEM
  Widget categoryItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: Colors.green),
          ),

          const SizedBox(height: 6),

          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
