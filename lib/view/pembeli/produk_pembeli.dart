import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:amicons/amicons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailProdukSc extends StatefulWidget {
  const DetailProdukSc({super.key});

  @override
  State<DetailProdukSc> createState() => _DetailProdukScState();
}

class _DetailProdukScState extends State<DetailProdukSc> {
  final PageController _controller = PageController();

  List<String> images = [
    "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
    "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
    "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
    "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
    "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
    "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
    "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
    "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
  ];

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
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: images.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.leafGreen,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Apel Malang (1Kg)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),

                Text(
                  "Rp 125.000",
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
                            "Malang, Jawa Timur",
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
                            "Tani Makmur Jaya",
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

                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     minimumSize: Size(0, 0),
                          //   ),
                          //   onPressed: () {},
                          //   child: Text(
                          //     "Laporkan Penjual",
                          //     style: TextStyle(
                          //       fontFamily: "Inter",
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
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
                  "Pupuk OrganiGrow Premium adalah solusi nutrisi tanaman terbaik yang diformulasikan khusus untuk meningkatkan hasil panen hingga 30%. Terbuat dari 100% bahan organik alami tanpa bahan kimia sintetis berbahaya..\n"
                  "Keunggulan: - Meningkatkan kesuburan tanah secara\n"
                  "berkelanjutan.\n"
                  "- Mempercepat pertumbuhan akar dan tunas baru.\n"
                  "- Ramah lingkungan dan aman bagi ekosistem\n"
                  "sekitar.\n"
                  "- Cocok untuk tanaman pangan, hortikultura,\n"
                  "maupun tanaman hias.",
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
