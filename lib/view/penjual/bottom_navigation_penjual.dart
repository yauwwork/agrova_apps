import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/home_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:agrova_apps/view/penjual/profil_penjual.dart';
import 'package:agrova_apps/view/penjual/tambah_produk.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class BottomNavigatorPenjual extends StatefulWidget {
  const BottomNavigatorPenjual({super.key});

  @override
  State<BottomNavigatorPenjual> createState() => _BottomNavigatorPenjualState();
}

class _BottomNavigatorPenjualState extends State<BottomNavigatorPenjual> {
  int _selectedIndex = 0;

  /// 🔥 LIST HALAMAN
  final List<Widget> _pages = [
    const HomePenjual(),
    const ProdukPenjual(),
    const TambahProduk(),
    const ProfilPenjualScreen(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,

      /// 🔥 BODY
      body: _pages[_selectedIndex],

      /// 🔥 FLOATING BOTTOM NAVBAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Amicons.remix_home4, "Beranda", 0),
            navItem(Amicons.iconly_bag_2_curved, "Produk", 1),
            navItem(Amicons.iconly_plus_curved, "Tambah", 2),
            navItem(Amicons.vuesax_profile_2user, "Profil", 3),
          ],
        ),
      ),
    );
  }

  /// =======================================================
  /// 🔥 NAV ITEM
  /// =======================================================
  Widget navItem(IconData icon, String label, int index) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.skyBlue.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive
                  ? AppColors.skyBlue
                  : AppColors.charcoal.withOpacity(0.4),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? AppColors.skyBlue
                    : AppColors.charcoal.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
