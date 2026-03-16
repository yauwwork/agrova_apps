import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:amicons/amicons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';

class DetailProdukSc extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String penjual;
  final String location;
  final String deskripsi;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DetailProdukSc({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.penjual,
    required this.location,
    required this.deskripsi,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<DetailProdukSc> createState() => _DetailProdukScState();
}

class _DetailProdukScState extends State<DetailProdukSc> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfffFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.leafGreen,
          ),
        ),

        centerTitle: true,
        title: Text(
          "Detail Produk",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Amicons.remix_share, color: AppColors.oceanBlue),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 250,
                    child: PageView(
                      controller: _controller,
                      children: [
                        Image.file(
                          File(widget.image),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 1,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.leafGreen,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),

                Text(
                  widget.price,
                  style: TextStyle(
                    color: AppColors.leafGreen,
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.skyBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Amicons.iconly_location_2_sharp,
                            color: AppColors.oceanBlue,
                            size: 20,
                          ),
                          SizedBox(width: 4),

                          Text(
                            widget.location,
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: AppColors.oceanBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.mintGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.leafGreen),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/gambarlain/download (1).jpg",
                        ),
                      ),

                      SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.penjual,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Amicons.remix_star_fill,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text("4.8 | 120 Ulasan"),
                            ],
                          ),

                          SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  "Deskripsi Produk",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  widget.deskripsi,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.5,
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mintGreen,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {},
          icon: Icon(Amicons.remix_whatsapp, color: AppColors.softMint),
          label: Text(
            "WhatsApp",
            style: TextStyle(
              color: AppColors.softMint,
              fontFamily: "Inter",
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
