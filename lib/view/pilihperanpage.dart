import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/rolecard.dart';
import 'package:flutter/material.dart';

class PilihPeranPage extends StatefulWidget {
  const PilihPeranPage({super.key});

  @override
  State<PilihPeranPage> createState() => _PilihPeranPageState();
}

class _PilihPeranPageState extends State<PilihPeranPage> {
  String? selectedRole; // 🔥 Menyimpan role yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brightGreen.withOpacity(0.5),
              AppColors.warmWhite,
              AppColors.oceanBlue.withOpacity(0.5),
            ],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 56),

              Text(
                "Pilih Peran Anda",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Bagaimana anda ingin menggunakan argova?",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 150),

              RoleCard(
                title: "Pembeli",
                description: "Jelajahi dan beli produk terbaik.",
                icon: Icons.shopping_bag_outlined,
                isSelected: selectedRole == "pembeli",
                onTap: () {
                  setState(() {
                    selectedRole = "pembeli";
                  });
                },
              ),

              RoleCard(
                title: "Penjual",
                description: "Jual produk anda ke pembeli.",
                icon: Icons.storefront_outlined,
                isSelected: selectedRole == "penjual",
                onTap: () {
                  setState(() {
                    selectedRole = "penjual";
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
