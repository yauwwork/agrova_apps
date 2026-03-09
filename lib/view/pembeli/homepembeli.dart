import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/productcard.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePembeli extends StatefulWidget {
  const HomePembeli({super.key});

  @override
  State<HomePembeli> createState() => _HomePembeliState();
}

class _HomePembeliState extends State<HomePembeli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.charcoal.withOpacity(0.3),
        selectedItemColor: AppColors.leafGreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Amicons.remix_home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.remix_grid),
            label: "Kategori",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.vuesax_lovely),
            label: "Favorit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.lucide_person_standing),
            label: "Profil",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang,",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            color: AppColors.oceanBlue,
                          ),
                        ),
                        //nanti diisi nama pembeli disini
                        Text(
                          "Agrova",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            color: AppColors.leafGreen,
                          ),
                        ),
                      ],
                    ),

                    //ini nanti kalo ada notif bisa muncul merah merah
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Amicons.remix_notification,
                        size: 30,
                        color: AppColors.oceanBlue,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: AppColors.charcoal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Cari Produk",
                          prefixIcon: Icon(Amicons.remix_search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),

                    Spacer(),

                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.charcoal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Amicons.remix_filter),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                CarouselSlider(
                  options: CarouselOptions(
                    height: 140,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    BannerItem("Promo Ramadhan", "Diskon s.d 70%"),
                    BannerItem("Promo Panen Raya", "Free ongkir seIndonesia"),
                    BannerItem("Promo telur", "Hanya Rp 25.000/Kg"),
                    BannerItem("Promo Ikan", "Diskon s.d 30%"),
                  ],
                ),

                SizedBox(height: 32),

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

                SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Produk Terbaik",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "Inter",
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Inter",
                          color: AppColors.leafGreen,
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCard(
                        title: "Bandeng",
                        price: "Rp 30.000/Kg",
                        image:
                            "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Sidoarjo, Jawa Timur",
                        rating: 4.8,
                      ),

                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Produk Terbaru",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "Inter",
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Inter",
                          color: AppColors.leafGreen,
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCard(
                        title: "Bandeng",
                        price: "Rp 30.000/Kg",
                        image:
                            "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Sidoarjo, Jawa Timur",
                        rating: 4.8,
                      ),

                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 26),

                //INI NANTI LOKASINYA BISA SESUAI DENGAN LOKASI USER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terdekat dari lokasimu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "Inter",
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Amicons.iconly_location,
                            color: AppColors.oceanBlue,
                          ),
                          // SizedBox(width: ),
                          Text(
                            "Jakarta Selatan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: "Inter",
                              color: AppColors.oceanBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCard(
                        title: "Bandeng",
                        price: "Rp 30.000/Kg",
                        image:
                            "assets/images/gambarlain/gregor-moser-QGIJUqnEpCY-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Sidoarjo, Jawa Timur",
                        rating: 4.8,
                      ),

                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                      SizedBox(width: 16),

                      ProductCard(
                        title: "Apel Malang",
                        price: "Rp 25.000/Kg",
                        image:
                            "assets/images/gambarlain/tobi-zLCR7RsxYGs-unsplash.jpg",
                        seller: "Pak Jono",
                        location: "Malang, Jawa Timur",
                        rating: 5.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //WIDGET ICON MENU
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

  //WIDGET BANNER
  Widget BannerItem(String title, String subtitle) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.leafGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: AppColors.warmWhite)),
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
}
