import 'package:agrova_apps/extension/card/produk_list_card.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget> [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bgpenjual,

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.charcoal.withOpacity(0.3),
        selectedItemColor: AppColors.skyBlue,
        backgroundColor: AppColors.bgpenjual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Amicons.remix_home4),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.iconly_plus_curved),
            label: "Tambah Produk",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.vuesax_profile_2user),
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/gambarlain/download (1).jpg",
                          ),
                          radius: 20,
                        ),

                        SizedBox(width: 8),

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

                SizedBox(height: 36),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      style: TextStyle(fontFamily: "Inter", fontSize: 12),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 170,
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
                            "Produk Dilihat",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "150",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: "Inter",
                                  color: AppColors.skyBlue,
                                ),
                              ),

                              SizedBox(width: 4),
                              Text(
                                "+15%",
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

                    Container(
                      width: 170,
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
                            "Produk Disukai",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "50",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: "Inter",
                                  color: AppColors.skyBlue,
                                ),
                              ),

                              SizedBox(width: 4),
                              Text(
                                "+10%",
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
                  ],
                ),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Produk Anda",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        fontSize: 20,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        print("Lihat Produk");
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

                SizedBox(height: 16),

                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ListCard(
                      name: "Ikan Kembung",
                      category: "Ikan",
                      price: "Rp 20.000/kg",
                      image: "assets/images/gambarlain/download (2).jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),

                    ListCard(
                      name: "Brokoli Ngawi",
                      category: "Sayur",
                      price: "Rp 7.000/kg",
                      image: "assets/images/gambarlain/🥦.jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),

                    ListCard(
                      name: "Tomat Kebumen",
                      category: "Sayur",
                      price: "Rp 15.000/kg",
                      image: "assets/images/gambarlain/download (3).jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),

                    ListCard(
                      name: "Ikan Kembung",
                      category: "Ikan",
                      price: "Rp 20.000/kg",
                      image: "assets/images/gambarlain/download (2).jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),

                    ListCard(
                      name: "Brokoli Ngawi",
                      category: "Sayur",
                      price: "Rp 7.000/kg",
                      image: "assets/images/gambarlain/🥦.jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),

                    ListCard(
                      name: "Tomat Kebumen",
                      category: "Sayur",
                      price: "Rp 15.000/kg",
                      image: "assets/images/gambarlain/download (3).jpg",
                      onEdit: () {
                        print("Edit Produk");
                      },
                      onDelete: () {
                        print("Delet PRODUK");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
