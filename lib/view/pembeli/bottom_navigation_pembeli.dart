import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/pembeli/favorit_screen.dart';
import 'package:agrova_apps/view/pembeli/home_pembeli.dart';
import 'package:agrova_apps/view/pembeli/katalog_screen.dart';
import 'package:agrova_apps/view/pembeli/profil_pembeli.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class BottomNavigationPembeli extends StatefulWidget {
  const BottomNavigationPembeli({super.key});

  @override
  State<BottomNavigationPembeli> createState() =>
      _BottomNavigationPembeliState();
}

class _BottomNavigationPembeliState extends State<BottomNavigationPembeli> {
  int _selectedIndex = 0;

  /// 🔥 LIST HALAMAN
  final List<Widget> _pages = [
    const HomePembeliScreen(),
    const KategoriSc(),
    const FavoritScreen(),
    const ProfilPembeli(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      /// 🔥 BODY
      body: _pages[_selectedIndex],

      /// 🔥 FLOATING NAVBAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 8),
              color: isDark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.08),
            ),
          ],
          border: isDark ? Border.all(color: Colors.white12) : null,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Amicons.remix_home4, "Beranda", 0, isDark),
            navItem(Amicons.lucide_grid_2x2, "Kategori", 1, isDark),
            navItem(Amicons.vuesax_lovely, "Favorit", 2, isDark),
            navItem(Amicons.vuesax_profile_2user, "Profil", 3, isDark),
          ],
        ),
      ),
    );
  }

  /// =======================================================
  /// 🔥 NAV ITEM
  /// =======================================================
  Widget navItem(IconData icon, String label, int index, bool isDark) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.mintGreen.withOpacity(0.15)
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
                  ? AppColors.mintGreen
                  : (isDark ? Colors.white60 : AppColors.charcoal.withOpacity(0.4)),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? AppColors.mintGreen
                    : (isDark ? Colors.white60 : AppColors.charcoal.withOpacity(0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
