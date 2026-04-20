import 'dart:async';
import 'dart:convert';

import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/user_models.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:agrova_apps/view/pembeli/produk_pembeli.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/services/favorite_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePembeliScreen extends StatefulWidget {
  const HomePembeliScreen({super.key});

  @override
  State<HomePembeliScreen> createState() => _HomePembeliScreenState();
}

class _HomePembeliScreenState extends State<HomePembeliScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _bannerTimer;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_pageController.hasClients) return;

      _currentPage = (_currentPage + 1) % 3;

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  String getNama(Map<String, dynamic>? data) {
    if (data == null) return "User Agrova";

    return data['nama'] ??
        data['name'] ??
        data['fullName'] ??
        data['username'] ??
        "User Agrova";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,
      body: StreamBuilder<List<ProductModel>>(
        stream: ProductService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allProducts = snapshot.data ?? [];

          final products = allProducts.where((p) {
            final name = (p.name ?? "").toLowerCase();
            return name.contains(_searchQuery);
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBanner(),
                      const SizedBox(height: 20),

                      /// 🔍 SEARCH (FIXED)
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: "Cari produk...",
                            border: InputBorder.none,
                            isCollapsed: true,
                            prefixIcon: Icon(Icons.search, size: 20),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// 🛍️ PRODUK
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final p = products[index];

                          return StreamBuilder<bool>(
                            stream: FavoriteService.isFavorited(p.id),
                            builder: (context, favSnap) {
                              final isFav = favSnap.data ?? false;

                              return ProductCard(
                                produk: p,
                                isFavorited: isFav,
                                onFavorite: (value) async {
                                  if (p.id == null) return;

                                  if (value) {
                                    await FavoriteService.addFavorite(p);
                                  } else {
                                    await FavoriteService.removeFavorite(p.id!);
                                  }
                                },

                                /// 🔥 NAVIGASI KE DETAIL
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailProdukSc(product: p),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ================= HEADER =================
  Widget _buildHeader() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3B82F6), Color(0xff22C55E)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: StreamBuilder<UserModeFirebase?>(
        stream: FirebaseService.userStream(user.uid),
        builder: (context, snapshot) {
          final userData = snapshot.data;
          final nama = userData?.username ?? user.displayName ?? "User Agrova";
          final photoBase64 = userData?.photoBase64;

          return Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white24,
                backgroundImage: photoBase64 != null
                    ? MemoryImage(base64Decode(photoBase64))
                    : const AssetImage("assets/profile.jpg") as ImageProvider,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat datang 👋",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications, color: Colors.white),
            ],
          );
        },
      ),
    );
  }

  /// ================= BANNER =================
  Widget _buildBanner() {
    return SizedBox(
      height: 160,
      child: PageView(
        controller: _pageController,
        children: const [
          _Banner("Produk Segar", "Langsung dari petani", Icons.eco),
          _Banner("Harga Murah", "Kualitas terbaik", Icons.shopping_bag),
          _Banner(
            "Pengiriman Cepat",
            "Aman sampai rumah",
            Icons.local_shipping,
          ),
        ],
      ),
    );
  }
}

/// ================= BANNER =================
class _Banner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _Banner(this.title, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3B82F6), Color(0xff22C55E)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Icon(icon, color: Colors.white, size: 40),
        ],
      ),
    );
  }
}
