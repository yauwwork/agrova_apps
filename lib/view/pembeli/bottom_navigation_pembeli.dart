import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/pembeli/favoritsc.dart';
import 'package:agrova_apps/view/pembeli/home_pembeli.dart';
import 'package:agrova_apps/view/pembeli/katalog_screen.dart';
import 'package:agrova_apps/view/pembeli/profil_pembeli.dart';
import 'package:agrova_apps/view/penjual/home_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:agrova_apps/view/penjual/profil_penjual.dart';
import 'package:agrova_apps/view/penjual/tambah_produk.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class HomePembeliSc extends StatefulWidget {
  const HomePembeliSc({super.key});

  @override
  State<HomePembeliSc> createState() => _HomePembeliSc();
}

class _HomePembeliSc extends State<HomePembeliSc> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePembeli(),
    KategoriSc(),
    FavoritSc(),
    PpPembeli(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.softMint,
        unselectedItemColor: AppColors.charcoal.withOpacity(0.3),
        selectedItemColor: AppColors.mintGreen,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Amicons.remix_home4),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.lucide_grid_2x2),
            label: "Kategori",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.vuesax_lovely),
            label: "Favorit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.vuesax_profile_2user),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
