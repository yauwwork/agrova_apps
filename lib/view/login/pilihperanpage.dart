import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/extension/card/role_card.dart';
import 'package:agrova_apps/view/pembeli/bottom_navigation_pembeli.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:flutter/material.dart';

class PilihPeranPage extends StatefulWidget {
  const PilihPeranPage({super.key});

  @override
  State<PilihPeranPage> createState() => _PilihPeranPageState();
}

class _PilihPeranPageState extends State<PilihPeranPage> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,

      body: Stack(
        children: [
          /// =========================
          /// 🔥 BACKGROUND (SOFT & GAK NORAK)
          /// =========================

          /// 🔵 kanan atas (fade smooth)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.blue.withOpacity(0.15), // tengah
                    Colors.blue.withOpacity(0.03), // pinggir
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// 🟢 kiri bawah (fade smooth)
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.green.withOpacity(0.15),
                    Colors.green.withOpacity(0.03),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// =========================
          /// 🔥 CONTENT
          /// =========================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// 🔥 TITLE
                  Column(
                    children: const [
                      Text(
                        "Pilih Peran",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Pilih bagaimana kamu ingin menggunakan Agrova",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// 🔥 ROLE CARD
                  Column(
                    children: [
                      RoleCard(
                        title: "Pembeli",
                        description: "Jelajahi dan beli produk terbaik",
                        icon: Icons.shopping_bag_outlined,
                        isSelected: selectedRole == "pembeli",
                        onTap: () {
                          setState(() {
                            selectedRole = "pembeli";
                          });

                          /// 🔥 kasih delay biar ada feedback klik
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BottomNavigationPembeli(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      RoleCard(
                        title: "Penjual",
                        description: "Jual produk anda ke pembeli",
                        icon: Icons.storefront_outlined,
                        isSelected: selectedRole == "penjual",
                        onTap: () {
                          setState(() {
                            selectedRole = "penjual"; // 🔥 FIX BUG
                          });

                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BottomNavigatorPenjual(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// 🔥 FOOTER
                  const Text(
                    "Kamu bisa mengubah peran nanti",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
