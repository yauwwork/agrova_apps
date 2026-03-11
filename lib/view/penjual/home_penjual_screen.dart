import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/home_penjual.dart';
import 'package:agrova_apps/view/penjual/produk_penjual.dart';
import 'package:agrova_apps/view/penjual/profil_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class HomePenjualSc extends StatefulWidget {
  const HomePenjualSc({super.key});

  @override
  State<HomePenjualSc> createState() => _HomePenjualScState();
}

class _HomePenjualScState extends State<HomePenjualSc> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePenjual(),
    ProdukPenjual(),
    ProfilPenjualSc(),
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
        unselectedItemColor: AppColors.charcoal.withOpacity(0.3),
        selectedItemColor: AppColors.skyBlue,
        backgroundColor: AppColors.bgpenjual,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Amicons.remix_home4),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Amicons.iconly_plus_curved),
            label: "Tambah Produk",
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
