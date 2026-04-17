import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/navigator.dart';
import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:agrova_apps/view/pembeli/bottom_navigation_pembeli.dart';
import 'package:agrova_apps/view/penjual/pengaturan_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// =======================================================
/// 🔥 SCREEN PROFIL PENJUAL
/// =======================================================
class ProfilPenjualScreen extends StatefulWidget {
  const ProfilPenjualScreen({super.key});

  @override
  State<ProfilPenjualScreen> createState() => _ProfilPenjualScreenState();
}

class _ProfilPenjualScreenState extends State<ProfilPenjualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,

      /// 🔥 HEADER
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
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

      /// 🔥 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            /// =====================================
            /// 🔥 PROFILE CARD
            /// =====================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
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
                  /// FOTO
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

                  /// NAMA
                  const Text(
                    "Radit Karbu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 4),

                  /// ROLE
                  const Text(
                    "Petani Agrova",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  /// =====================================
                  /// 🔥 LOKASI (VERSI SIMPLE, NO CONTAINER)
                  /// =====================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on, size: 14, color: Colors.red),
                      SizedBox(width: 4),
                      Text(
                        "Blok M, Jakarta Selatan",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// =====================================
            /// 🔥 AKTIVITAS
            /// =====================================
            _sectionTitle("Aktivitas Saya"),
            const SizedBox(height: 10),

            _menuCard([
              _menuItem(
                icon: Icons.inventory_2_outlined,
                color: Colors.green,
                title: "Produk Saya",
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
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BottomNavigationPembeli(),
                    ),
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

            /// =====================================
            /// 🔥 LAINNYA
            /// =====================================
            _sectionTitle("Lainnya"),
            const SizedBox(height: 10),

            _menuCard([
              _menuItem(
                icon: Amicons.remix_settings,
                color: Colors.green,
                title: "Pengaturan",
                onTap: () {
                  context.push(const PengaturanPenjual());
                },
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

  /// 🔥 TITLE
  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// 🔥 CARD
  Widget _menuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  /// 🔥 ITEM
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
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}
