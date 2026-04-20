import 'dart:convert';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/navigator.dart';
import 'package:agrova_apps/models/user_models.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:agrova_apps/view/pembeli/edit_profil_pembeli.dart';
import 'package:agrova_apps/view/pembeli/pengaturan_pembeli.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilPembeli extends StatefulWidget {
  const ProfilPembeli({super.key});

  @override
  State<ProfilPembeli> createState() => _ProfilPembeliState();
}

class _ProfilPembeliState extends State<ProfilPembeli> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) return const Scaffold(body: Center(child: Text("Silahkan Login")));

    return Scaffold(
      backgroundColor: AppColors.softMint,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
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
      body: StreamBuilder<UserModeFirebase?>(
        stream: FirebaseService.userStream(user!.uid),
        builder: (context, snapshot) {
          final userData = snapshot.data;
          String nama = userData?.username ?? user?.displayName ?? "User Agrova";
          String email = userData?.email ?? user?.email ?? "-";
          String? photoBase64 = userData?.photoBase64;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              children: [
                /// PROFILE CARD
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
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: photoBase64 != null
                            ? MemoryImage(base64Decode(photoBase64))
                            : const AssetImage("assets/images/gambarlain/download (1).jpg") as ImageProvider,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(email, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                _sectionTitle("Aktivitas Saya"),
                const SizedBox(height: 10),
                _menuCard([
                  _menuItem(
                    icon: Amicons.iconly_profile_sharp,
                    color: Colors.orange,
                    title: "Edit Profil",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EditProfilPembeli()),
                      );
                    },
                  ),
                  _menuItem(
                    icon: Amicons.vuesax_cloud_change,
                    color: Colors.blue,
                    title: "Beralih Ke Penjual",
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomNavigatorPenjual(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ]),
                const SizedBox(height: 20),
                _sectionTitle("Lainnya"),
                const SizedBox(height: 10),
                _menuCard([
                  _menuItem(
                    icon: Amicons.remix_settings,
                    color: Colors.green,
                    title: "Pengaturan",
                    onTap: () {
                      context.push(const PengaturanPembeli());
                    },
                  ),
                  _menuItem(
                    icon: Amicons.lucide_log_out,
                    color: Colors.red,
                    title: "Keluar Akun",
                    onTap: () async {
                      await FirebaseService.logout();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Loginscreen()),
                        (route) => false,
                      );
                    },
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _menuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

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
