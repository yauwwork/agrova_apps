import 'dart:convert';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalitikScreen extends StatefulWidget {
  const AnalitikScreen({super.key});

  @override
  State<AnalitikScreen> createState() => _AnalitikScreenState();
}

class _AnalitikScreenState extends State<AnalitikScreen> {
  int selectedTab = 0; // 0 = Mingguan, 1 = Bulanan

  /// 🔥 DATA DUMMY (Untuk grafik karena belum ada tracking historis per hari)
  final List<double> dataMingguan = [300, 450, 380, 520, 600, 480, 580];
  final List<double> dataBulanan = [500, 700, 650, 800, 900, 750, 880];

  @override
  Widget build(BuildContext context) {
    final data = selectedTab == 0 ? dataMingguan : dataBulanan;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: StreamBuilder<List<ProductModel>>(
        stream: ProductService.getMyProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data ?? [];

          // Hitung Statistik
          int totalViews = 0;
          int totalFavorites = 0;
          int activeProducts = 0;
          Map<String, int> categoryCount = {};

          for (var p in products) {
            totalViews += p.views;
            totalFavorites += p.favorites;
            if (p.stock > 0) activeProducts++;

            categoryCount[p.category] = (categoryCount[p.category] ?? 0) + 1;
          }

          // Urutkan produk berdasarkan performa (views + favorites)
          List<ProductModel> sortedProducts = List.from(products);
          sortedProducts.sort((a, b) => (b.views + b.favorites).compareTo(a.views + a.favorites));
          final topProducts = sortedProducts.take(3).toList();

          // Distribusi Kategori
          List<MapEntry<String, int>> sortedCategories = categoryCount.entries.toList();
          sortedCategories.sort((a, b) => b.value.compareTo(a.value));
          final topCategories = sortedCategories.take(3).toList();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= HEADER =================
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: boxStyle(),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Analitik",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ================= STAT CARD =================
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.2,
                    children: [
                      StatCard(
                        Icons.inventory_2,
                        "${products.length}",
                        "Total Produk",
                        "$activeProducts aktif",
                        Colors.green,
                      ),
                      StatCard(
                        Icons.remove_red_eye,
                        formatNumber(totalViews),
                        "Total Dilihat",
                        "Seluruh waktu",
                        Colors.blue,
                      ),
                      StatCard(
                        Icons.favorite_border,
                        formatNumber(totalFavorites),
                        "Total Favorit",
                        "Penyuka produk",
                        Colors.pink,
                      ),
                      StatCard(
                        Icons.trending_up,
                        activeProducts > 0 ? "${(totalViews / activeProducts).toStringAsFixed(1)}" : "0",
                        "Avg Views",
                        "Per produk",
                        Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ================= CHART =================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: boxStyle(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Statistik Performa Produk",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 180,
                          child: products.isEmpty 
                            ? const Center(child: Text("Tidak ada data", style: TextStyle(color: Colors.grey)))
                            : BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barTouchData: BarTouchData(enabled: true),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() < products.length) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            products[value.toInt()].name.length > 5 
                                                ? "${products[value.toInt()].name.substring(0, 5)}.." 
                                                : products[value.toInt()].name,
                                            style: const TextStyle(fontSize: 9),
                                          ),
                                        );
                                      }
                                      return const Text("");
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              gridData: const FlGridData(show: true, drawVerticalLine: false),
                              borderData: FlBorderData(show: false),
                              barGroups: List.generate(products.length > 7 ? 7 : products.length, (index) {
                                final p = products[index];
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: p.views.toDouble(),
                                      width: 14,
                                      gradient: const LinearGradient(
                                        colors: [Colors.green, Colors.blue],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(child: Text("Menampilkan penayangan per produk", style: TextStyle(fontSize: 10, color: Colors.grey))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ================= DISTRIBUSI =================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: boxStyle(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Distribusi Kategori",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        if (products.isEmpty)
                          const Text("Belum ada data kategori", style: TextStyle(color: Colors.grey, fontSize: 12))
                        else
                          ...topCategories.map((e) {
                            final percent = e.value / products.length;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ProgressItem(e.key, percent, getColorForCategory(e.key)),
                            );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ================= PRODUK TERLARIS =================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: boxStyle(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Performa Produk Teratas",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        if (topProducts.isEmpty)
                          const Text("Belum ada data produk", style: TextStyle(color: Colors.grey, fontSize: 12))
                        else
                          ...topProducts.asMap().entries.map((entry) {
                            final i = entry.key;
                            final p = entry.value;
                            return ProductItem(
                              i + 1,
                              p.imageBase64,
                              p.name,
                              formatNumber(p.views),
                              "${p.favorites}",
                              "5.0",
                            );
                          }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String formatNumber(int number) {
    if (number >= 1000) return "${(number / 1000).toStringAsFixed(1)}k";
    return number.toString();
  }

  Color getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'buah-buahan': return Colors.orange;
      case 'sayuran': return Colors.green;
      case 'ikan': return Colors.blue;
      case 'daging': return Colors.red;
      case 'telur': return Colors.amber;
      default: return Colors.purple;
    }
  }

  Widget tabItem(String text, int index) {
    final isActive = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

BoxDecoration boxStyle() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(blurRadius: 10, offset: const Offset(0, 4), color: Colors.black.withOpacity(0.05)),
    ],
  );
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value, title, subtitle;
  final Color color;

  const StatCard(this.icon, this.value, this.title, this.subtitle, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: boxStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

class ProgressItem extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  const ProgressItem(this.title, this.value, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.grey.shade100,
            color: color,
          ),
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final int rank;
  final String imageBase64, title, views, likes, rating;

  const ProductItem(this.rank, this.imageBase64, this.title, this.views, this.likes, this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF7F8FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text("$rank", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageBase64.isNotEmpty
                ? Image.memory(base64Decode(imageBase64), width: 45, height: 45, fit: BoxFit.cover)
                : Container(width: 45, height: 45, color: Colors.grey.shade300),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  "$views tayangan • ❤️ $likes",
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.orange),
              const SizedBox(width: 2),
              Text(rating, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
