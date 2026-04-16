import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:agrova_apps/view/pembeli/bottom_navigation_pembeli.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🔥 SCREEN PROFIL PENJUAL
class ProfilPenjualScreen extends StatefulWidget {
  const ProfilPenjualScreen({super.key});

  @override
  State<ProfilPenjualScreen> createState() => _ProfilPenjualScreenState();
}

class _ProfilPenjualScreenState extends State<ProfilPenjualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      /// 🔥 APPBAR (CONSISTENT DENGAN SCREEN LAIN)
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,

        /// bikin bagian bawah melengkung
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),

        /// gradient warna
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3B82F6), Color(0xff22C55E)],
            ),
          ),
        ),

        title: const Text(
          "Profil Saya",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            /// ================================
            /// 🔥 PROFILE CARD
            /// ================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                /// gradient halus biar gak flat
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.green.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  /// FOTO PROFIL + ICON EDIT
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          "assets/images/gambarlain/download (1).jpg",
                        ),
                      ),

                      /// tombol kamera
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xff3B82F6),
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

                  const SizedBox(height: 12),

                  /// NAMA USER
                  const Text(
                    "Radit Karbu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 6),

                  /// ROLE / STATUS
                  const Text(
                    "Petani Agrova",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 12),

                  /// LOKASI
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Blok M, Jakarta Selatan",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================================
            /// 🔥 AKTIVITAS SAYA
            /// ================================
            _sectionTitle("Aktivitas Saya"),
            const SizedBox(height: 10),

            _menuCard([
              _menuItem(
                icon: Icons.inventory_2_outlined,
                color: Colors.green,
                title: "Produk Saya",

                /// navigasi ke halaman produk
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProdukPenjual()),
                  );
                },
              ),

              _menuItem(
                icon: Amicons.vuesax_cloud_change,
                color: Colors.blue,
                title: "Beralih ke Pembeli",

                /// pindah role ke pembeli
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePembeliSc()),
                    (route) => false,
                  );
                },
              ),

              _menuItem(
                icon: Amicons.vuesax_profile_circle,
                color: Colors.orange,
                title: "Edit Profil",
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 20),

            /// ================================
            /// 🔥 MENU LAINNYA
            /// ================================
            _sectionTitle("Lainnya"),
            const SizedBox(height: 10),

            _menuCard([
              _menuItem(
                icon: Amicons.remix_settings,
                color: Colors.green,
                title: "Pengaturan",
                onTap: () {},
              ),

              _menuItem(
                icon: Amicons.remix_question,
                color: Colors.blue,
                title: "Pusat Bantuan",
                onTap: () {},
              ),

              _menuItem(
                icon: Amicons.lucide_log_out,
                color: Colors.red,
                title: "Keluar Akun",

                /// LOGOUT
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.clear();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Loginscreen()),
                    (route) => false,
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  /// ================================
  /// 🔥 TITLE SECTION
  /// ================================
  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// ================================
  /// 🔥 CARD MENU
  /// ================================
  Widget _menuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  /// ================================
  /// 🔥 ITEM MENU
  /// ================================
  Widget _menuItem({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),

        /// garis pemisah
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}
