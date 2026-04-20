import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/services/favorite_service.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';

class HomePembeliScreen extends StatefulWidget {
  const HomePembeliScreen({super.key});

  @override
  State<HomePembeliScreen> createState() => _HomePembeliScreenState();
}

class _HomePembeliScreenState extends State<HomePembeliScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,

      body: StreamBuilder<List<ProductModel>>(
        stream: ProductService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi error Firebase"));
          }

          final products = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildKategori(),
                      const SizedBox(height: 16),
                      _buildBanner(),
                      const SizedBox(height: 20),

                      /// ================= PRODUK UNGGULAN =================
                      _sectionTitle("Produk Unggulan"),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final p = products[index];

                            return Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 12),

                              child: StreamBuilder<bool>(
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
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ================= SEMUA PRODUK =================
                      _sectionTitle("Semua Produk"),
                      const SizedBox(height: 10),

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
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3B82F6), Color(0xff22C55E)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              CircleAvatar(radius: 20, backgroundImage: AssetImage("assets/profile.jpg")),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat pagi 👋", style: TextStyle(color: Colors.white70)),
                  Text("Ahmad",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Spacer(),
              Icon(Icons.notifications, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Cari produk...",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategori() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _KategoriItem(Icons.eco, "Pertanian", Colors.green),
          _KategoriItem(Icons.set_meal, "Perikanan", Colors.blue),
          _KategoriItem(Icons.grass, "Peternakan", Colors.orange),
          _KategoriItem(Icons.inventory, "Komoditas", Colors.purple),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 160,
      child: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentPage = i),
        children: const [
          _Banner("Produk Segar", "Langsung dari petani terbaik", Icons.eco),
          _Banner("Harga Terjangkau", "Kualitas terbaik", Icons.shopping_bag),
          _Banner("Pengiriman Cepat", "Aman sampai rumah", Icons.local_shipping),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Text("Lihat Semua", style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}

class _KategoriItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _KategoriItem(this.icon, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _Banner(this.title, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Icon(icon, color: Colors.white, size: 40),
        ],
      ),
    );
  }
}