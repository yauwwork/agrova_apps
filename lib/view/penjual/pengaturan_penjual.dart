import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';

class PengaturanPenjual extends StatefulWidget {
  const PengaturanPenjual({super.key});

  @override
  State<PengaturanPenjual> createState() => _PengaturanPenjualState();
}

class _PengaturanPenjualState extends State<PengaturanPenjual> {
  bool modeTerang = false;
  bool notifPush = true;
  bool pesan = true;
  bool updateProduk = true;
  bool promo = false;

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
              /// HEADER
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

              /// 🔥 TAMPILAN
              sectionTitle("TAMPILAN"),
              settingCard([
                switchItem(
                  "Mode Terang",
                  "Tampilan terang aktif",
                  Icons.light_mode,
                  Colors.orange,
                  modeTerang,
                  (v) => setState(() => modeTerang = v),
                ),
                arrowItem(
                  "Bahasa",
                  "Bahasa Indonesia",
                  Icons.language,
                  Colors.blue,
                ),
              ]),

              const SizedBox(height: 20),

              /// 🔥 NOTIFIKASI
              sectionTitle("NOTIFIKASI"),
              settingCard([
                switchItem(
                  "Notifikasi Push",
                  "Real-time",
                  Icons.notifications,
                  Colors.green,
                  notifPush,
                  (v) => setState(() => notifPush = v),
                ),
                switchItem(
                  "Pesan",
                  "Pesan baru",
                  Icons.message,
                  Colors.blue,
                  pesan,
                  (v) => setState(() => pesan = v),
                ),
                switchItem(
                  "Update Produk",
                  "Produk diperbarui",
                  Icons.system_update,
                  Colors.purple,
                  updateProduk,
                  (v) => setState(() => updateProduk = v),
                ),
                switchItem(
                  "Promo & Penawaran",
                  "Diskon & promo",
                  Icons.campaign,
                  Colors.orange,
                  promo,
                  (v) => setState(() => promo = v),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// 🔥 COMPONENT
/// =======================================================

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
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.05)),
      ],
    ),
    child: Column(children: children),
  );
}

/// =======================================================
/// 🔥 SWITCH ITEM (UPDATED - PREMIUM)
/// =======================================================
Widget switchItem(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  bool value,
  Function(bool) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        /// ICON
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),

        const SizedBox(width: 12),

        /// TEXT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        /// 🔥 CUSTOM SWITCH
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 50,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: value
                  ? LinearGradient(colors: [color.withOpacity(0.7), color])
                  : null,
              color: value ? null : Colors.grey.shade300,
              boxShadow: value
                  ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8)]
                  : [],
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// =======================================================
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
