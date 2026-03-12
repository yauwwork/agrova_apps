import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/card/produk_card.dart';
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
      backgroundColor: Color(0xfffFFFFF),
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
                  itemCount: 27,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: "Apel Malang",
                      price: "Rp 25.000/Kg",
                      image:
                          "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                      seller: "Pak Jono",
                      location: "Malang, Jawa Timur",
                      rating: 5.0,
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
