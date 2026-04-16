import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPembeli extends StatefulWidget {
  const ProfilPembeli({super.key});

  @override
  State<ProfilPembeli> createState() => _ProfilPembeliState();
}

class _ProfilPembeliState extends State<ProfilPembeli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔥 HEADER + PROFILE CARD (STACK BIAR OVERLAP)
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// 🌈 HEADER GRADIENT
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff3B82F6), Color(0xff22C55E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                  ),
                ),

                /// 👤 PROFILE CARD (OVERLAP)
                Positioned(
                  bottom: -60,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.08),
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// AVATAR
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(
                                "assets/images/gambarlain/download (1).jpg",
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// NAMA
                        const Text(
                          "Radit Karbu",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 4),

                        /// ALAMAT
                        const Text(
                          "Jakarta Selatan, DKI Jakarta",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 80), // penting biar gak ketutup
            /// 🔥 BODY
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// AKTIVITAS
                  _sectionTitle("Aktivitas Saya"),
                  const SizedBox(height: 10),

                  _menuCard([
                    _menuItem(
                      icon: Amicons.flaticon_comment_rounded,
                      color: Colors.green,
                      title: "Ulasan Saya",
                      onTap: () {},
                    ),
                    _divider(),
                    _menuItem(
                      icon: Amicons.iconly_profile_sharp,
                      color: Colors.orange,
                      title: "Edit Profil",
                      onTap: () {},
                    ),
                    _divider(),
                    _menuItem(
                      icon: Amicons.vuesax_cloud_change,
                      color: Colors.blue,
                      title: "Beralih Ke Penjual",
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePenjualSc(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ]),

                  const SizedBox(height: 20),

                  /// LAINNYA
                  _sectionTitle("Lainnya"),
                  const SizedBox(height: 10),

                  _menuCard([
                    _menuItem(
                      icon: Amicons.remix_settings,
                      color: Colors.green,
                      title: "Pengaturan",
                      onTap: () {},
                    ),
                    _divider(),
                    _menuItem(
                      icon: Amicons.remix_question,
                      color: Colors.blue,
                      title: "Pusat Bantuan",
                      onTap: () {},
                    ),
                    _divider(),
                    _menuItem(
                      icon: Amicons.lucide_log_out,
                      color: Colors.red,
                      title: "Keluar Akun",
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginscreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TITLE
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// CARD MENU
  Widget _menuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// ITEM MENU
  Widget _menuItem({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey[300]);
  }
}
