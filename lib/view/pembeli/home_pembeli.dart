import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/database/produk_data.dart';
import 'package:agrova_apps/extension/card/pembeli_produk_card.dart';

class HomePembeliScreen extends StatefulWidget {
  const HomePembeliScreen({super.key});

  @override
  State<HomePembeliScreen> createState() => _HomePembeliScreenState();
}

class _HomePembeliScreenState extends State<HomePembeliScreen> {
  /// 🔥 CONTROLLER BUAT CAROUSEL
  final PageController _pageController = PageController();

  /// 🔥 INDEX BANNER AKTIF
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ===============================
            /// 🔥 HEADER (GRADIENT + USER INFO)
            /// ===============================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3B82F6), Color(0xff22C55E)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  /// 👤 USER INFO
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat pagi 👋",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Ahmad",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Spacer(),

                      /// 🔔 NOTIF
                      Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 🔍 SEARCH BAR
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
            ),

            /// ===============================
            /// 🔥 BODY
            /// ===============================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===============================
                  /// 🟢 KATEGORI
                  /// ===============================
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    /// LIST ICON KATEGORI
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _KategoriItem(Icons.eco, "Pertanian", Colors.green),
                        _KategoriItem(Icons.set_meal, "Perikanan", Colors.blue),
                        _KategoriItem(Icons.grass, "Peternakan", Colors.orange),
                        _KategoriItem(
                          Icons.inventory,
                          "Komoditas",
                          Colors.purple,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ===============================
                  /// 🎯 BANNER CAROUSEL
                  /// ===============================
                  SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        /// 🔥 SLIDER
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },

                            children: [
                              _bannerItem(
                                "Produk Segar",
                                "Langsung dari petani terbaik",
                                Icons.eco,
                              ),
                              _bannerItem(
                                "Harga Terjangkau",
                                "Kualitas terbaik setiap hari",
                                Icons.shopping_bag,
                              ),
                              _bannerItem(
                                "Pengiriman Cepat",
                                "Sampai rumah dengan aman",
                                Icons.local_shipping,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// 🔥 DOT INDICATOR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentPage == index ? 12 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? Colors.green
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ===============================
                  /// 🔥 PRODUK UNGGULAN
                  /// ===============================
                  _sectionTitle("Produk Unggulan"),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: daftarProduk.length,
                      itemBuilder: (context, index) {
                        final produk = daftarProduk[index];

                        return Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 12),

                          /// 🔥 PAKE PRODUCT CARD LO
                          child: ProductCard(
                            title: produk.nama,
                            price: "Rp ${produk.harga}/kg",
                            image: produk.image,
                            seller: produk.penjual,
                            location: produk.lokasi,
                            rating: 4.5,

                            /// ❤️ FAVORIT LOGIC
                            isFavorited: favoritProduk.contains(produk),
                            onFavorite: () {
                              setState(() {
                                if (favoritProduk.contains(produk)) {
                                  favoritProduk.remove(produk);
                                } else {
                                  favoritProduk.add(produk);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ===============================
                  /// 🔥 TERAKHIR DILIHAT
                  /// ===============================
                  _sectionTitle("Terakhir Dilihat"),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: daftarProduk.length,
                      itemBuilder: (context, index) {
                        final produk = daftarProduk[index];

                        return Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),

                            /// ⚠️ NOTE:
                            /// kalau image dari File → pakai Image.file
                            /// kalau dari assets → pakai Image.asset
                            child: Image.asset(produk.image, fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ===============================
                  /// 🔥 SEMUA PRODUK
                  /// ===============================
                  _sectionTitle("Semua Produk"),
                  const SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daftarProduk.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      final produk = daftarProduk[index];

                      return ProductCard(
                        title: produk.nama,
                        price: "Rp ${produk.harga}/kg",
                        image: produk.image,
                        seller: produk.penjual,
                        location: produk.lokasi,
                        rating: 4.5,
                        isFavorited: favoritProduk.contains(produk),
                        onFavorite: () {
                          setState(() {
                            if (favoritProduk.contains(produk)) {
                              favoritProduk.remove(produk);
                            } else {
                              favoritProduk.add(produk);
                            }
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================
  /// 🎯 WIDGET BANNER
  /// ===============================
  Widget _bannerItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff3B82F6), Color(0xff22C55E)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

  /// ===============================
  /// 🧾 TITLE SECTION
  /// ===============================
  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Text("Lihat Semua", style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}

/// ===============================
/// 🟢 ITEM KATEGORI
/// ===============================
class _KategoriItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _KategoriItem(this.icon, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ICON BULAT
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),

        const SizedBox(height: 6),

        /// TEXT
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
