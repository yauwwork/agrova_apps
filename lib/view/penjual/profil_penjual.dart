import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPenjualSc extends StatefulWidget {
  const ProfilPenjualSc({super.key});

  @override
  State<ProfilPenjualSc> createState() => _ProfilPenjualScState();
}

class _ProfilPenjualScState extends State<ProfilPenjualSc> {
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
          "Profil Saya",
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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   color: Color(0xffffffff),
                  //   borderRadius: BorderRadius.circular(16),
                  // ),
                  decoration: BoxDecoration(
                    color: AppColors.skyBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.skyBlue),
                  ),
                  width: double.infinity,
                  height: 265,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.skyBlue,
                                    blurRadius: 10,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  "assets/images/gambarlain/download (1).jpg",
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.skyBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    print("Ganti foto");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        Text(
                          "Radit Karbu",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 24,
                          ),
                        ),

                        SizedBox(height: 16),

                        Container(
                          width: 320,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.warmWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.skyBlue),
                          ),

                          child: Center(
                            child: Text(
                              "Jl nin aja dulu, Blok M, Jaksel, DKI Jakarta, 1312",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Inter",
                                color: AppColors.darkTeal,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Aktivitas Saya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Inter",
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.green,
                          ),
                        ),
                        title: Text("Produk Saya"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProdukPenjual()),
                          );
                        },
                      ),

                      Divider(color: Colors.grey.shade300, thickness: 1),

                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Amicons.remix_notification3,
                            color: Colors.red,
                          ),
                        ),
                        title: Text("Notifikasi"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          print("ping");
                        },
                      ),

                      Divider(color: Colors.grey.shade300, thickness: 1),

                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Amicons.remix_star_fill,
                            color: Colors.amber,
                          ),
                        ),
                        title: Text("Rating Saya"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          print("Rating");
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Lainnya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Inter",
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Amicons.remix_settings,
                            color: Colors.green,
                          ),
                        ),
                        title: Text("Pengaturan"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          print("Pengaturan");
                        },
                      ),

                      Divider(color: Colors.grey.shade300, thickness: 1),

                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.oceanBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Amicons.remix_question,
                            color: AppColors.oceanBlue,
                          ),
                        ),
                        title: Text("Pusat Bantuan"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          print("Pusat Bantuan");
                        },
                      ),

                      Divider(color: Colors.grey.shade300, thickness: 1),

                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Amicons.lucide_log_out,
                            color: Colors.red,
                          ),
                        ),
                        title: Text("Keluar Akun"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          await prefs.clear(); // hapus semua data login

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loginscreen(),
                            ),
                            (route) => false,
                          );
                        },
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
}
