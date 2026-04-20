import 'dart:convert';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailProdukSc extends StatefulWidget {
  final String title;
  final String price;
  final String imageBase64; // 🔥 dari firebase
  final String penjual;
  final String location;
  final String deskripsi;

  const DetailProdukSc({
    super.key,
    required this.title,
    required this.price,
    required this.imageBase64,
    required this.penjual,
    required this.location,
    required this.deskripsi,
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
      backgroundColor: AppColors.softMint,

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),

        centerTitle: true,
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.black),
          ),
        ],
      ),

      /// ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ================= IMAGE =================
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 250,
                    child: PageView(
                      controller: _controller,
                      children: [
                        widget.imageBase64.isNotEmpty
                            ? Image.memory(
                                base64Decode(widget.imageBase64),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image, size: 60),
                              ),
                      ],
                    ),
                  ),
                ),
              ),

              /// DOT
              SmoothPageIndicator(
                controller: _controller,
                count: 1,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: AppColors.mintGreen,
                ),
              ),

              const SizedBox(height: 20),

              /// ================= CONTENT =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Text(
                      widget.price,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LOCATION
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          widget.location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// ================= SELLER =================
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/profile.jpg"),
                          ),

                          const SizedBox(width: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.penjual,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: const [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 16),
                                  SizedBox(width: 4),
                                  Text("4.8"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ================= DESKRIPSI =================
                    const Text(
                      "Deskripsi Produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.deskripsi,
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// ================= BUTTON =================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mintGreen,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            /// 🔥 nanti bisa launch whatsapp
          },
          icon: const Icon(Icons.chat, color: Colors.white),
          label: const Text(
            "Hubungi via WhatsApp",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}