import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/view/penjual/analitik_screen.dart';
import 'package:flutter/material.dart';

class HomePenjual extends StatefulWidget {
  const HomePenjual({super.key});

  @override
  State<HomePenjual> createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgpenjual,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// =======================================================
            /// 🔥 HEADER + STAT CARD
            /// =======================================================
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// 🔥 HEADER (GRADIENT)
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 80),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.skyBlue, AppColors.mintGreen],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// FOTO PROFILE
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      const SizedBox(width: 10),

                      /// NAMA USER
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Dashboard Penjual 🏪",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Andi Wijaya",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      /// ICON NOTIF
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                ),

                /// 🔥 STAT CARD (FLOATING)
                Positioned(
                  bottom: -40,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        StatItem(
                          Icons.inventory,
                          "12",
                          "Produk",
                          AppColors.mintGreen,
                        ),
                        StatItem(
                          Icons.remove_red_eye,
                          "15.7k",
                          "Dilihat",
                          AppColors.skyBlue,
                        ),
                        StatItem(Icons.favorite, "892", "Favorit", Colors.pink),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// 🔥 SPACING BIAR CARD KELIHATAN
            const SizedBox(height: 60),

            /// =======================================================
            /// 🔥 MENU
            /// =======================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  /// 🔹 TAMBAH
                  const Expanded(
                    child: MenuCard(Icons.add, "Tambah", AppColors.mintGreen),
                  ),

                  const SizedBox(width: 10),

                  /// 🔥 ANALITIK (CLICKABLE)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AnalitikScreen(),
                          ),
                        );
                      },
                      child: const MenuCard(
                        Icons.show_chart,
                        "Analitik",
                        AppColors.skyBlue,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// 🔹 PRODUK
                  const Expanded(
                    child: MenuCard(
                      Icons.inventory_2,
                      "Produk",
                      AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// =======================================================
            /// 🔥 TITLE
            /// =======================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Produk Terlaris",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    "Analitik",
                    style: TextStyle(
                      color: AppColors.skyBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 (NANTI BISA TAMBAH LIST PRODUK DI SINI)
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// 🔥 STAT ITEM (ATAS)
/// =======================================================
class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatItem(this.icon, this.value, this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ICON
        Icon(icon, color: color),

        const SizedBox(height: 6),

        /// VALUE
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        /// LABEL
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}

/// =======================================================
/// 🔥 MENU CARD (UPDATED UI MODERN)
/// =======================================================
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const MenuCard(this.icon, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,

      /// 🔥 STYLE CARD
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🔥 ICON BOX (MODERN)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 8),

          /// 🔥 TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
