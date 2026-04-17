import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';

class PengaturanPembeli extends StatefulWidget {
  const PengaturanPembeli({super.key});

  @override
  State<PengaturanPembeli> createState() => _PengaturanPembeliState();
}

class _PengaturanPembeliState extends State<PengaturanPembeli> {
  bool notifPush = true;
  bool pesan = true;
  bool updateProduk = true;
  bool promo = false;
  bool verifikasi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔥 HEADER
              Row(
                children: [
                  backBtn(context),
                  const SizedBox(width: 10),
                  const Text(
                    "Pengaturan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              sectionTitle("NOTIFIKASI"),
              settingCard([
                switchItem(
                  "Notifikasi Push",
                  "Terima notifikasi real-time",
                  Icons.notifications,
                  Colors.green,
                  notifPush,
                  (v) {
                    setState(() => notifPush = v);
                  },
                ),
                switchItem(
                  "Pesan",
                  "Notifikasi pesan baru",
                  Icons.message,
                  Colors.blue,
                  pesan,
                  (v) {
                    setState(() => pesan = v);
                  },
                ),
                switchItem(
                  "Update Produk",
                  "Produk favorit diperbarui",
                  Icons.system_update,
                  Colors.purple,
                  updateProduk,
                  (v) {
                    setState(() => updateProduk = v);
                  },
                ),
                switchItem(
                  "Promo & Penawaran",
                  "Penawaran spesial dan diskon",
                  Icons.campaign,
                  Colors.orange,
                  promo,
                  (v) {
                    setState(() => promo = v);
                  },
                ),
              ]),

              const SizedBox(height: 20),

              sectionTitle("PRIVASI & KEAMANAN"),
              settingCard([
                arrowItem(
                  "Ubah Password",
                  "Perbarui kata sandi Anda",
                  Icons.lock,
                  Colors.green,
                ),
                switchItem(
                  "Verifikasi 2 Langkah",
                  "Keamanan ekstra untuk akun",
                  Icons.verified_user,
                  Colors.blue,
                  verifikasi,
                  (v) {
                    setState(() => verifikasi = v);
                  },
                ),
                arrowItem(
                  "Kebijakan Privasi",
                  "Pelajari cara kami melindungi data Anda",
                  Icons.privacy_tip,
                  Colors.grey,
                ),
              ]),

              const SizedBox(height: 20),

              sectionTitle("LAINNYA"),
              settingCard([
                arrowItem(
                  "Tentang AgriMart",
                  "Versi 1.0.0",
                  Icons.info,
                  Colors.blue,
                ),
                arrowItem(
                  "Hapus Akun",
                  "Hapus akun secara permanen",
                  Icons.delete,
                  Colors.red,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget settingCard(List<Widget> children) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
      ],
    ),
    child: Column(children: children),
  );
}

Widget switchItem(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  bool value,
  Function(bool) onChanged,
) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: color.withOpacity(0.15),
      child: Icon(icon, color: color),
    ),
    title: Text(title),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    trailing: Switch(value: value, onChanged: onChanged),
  );
}

Widget arrowItem(String title, String subtitle, IconData icon, Color color) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: color.withOpacity(0.15),
      child: Icon(icon, color: color),
    ),
    title: Text(title),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    trailing: const Icon(Icons.chevron_right),
  );
}

Widget backBtn(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.arrow_back_ios_new, size: 16),
    ),
  );
}
