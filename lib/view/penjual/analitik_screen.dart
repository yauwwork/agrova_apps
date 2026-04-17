import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalitikScreen extends StatefulWidget {
  const AnalitikScreen({super.key});

  @override
  State<AnalitikScreen> createState() => _AnalitikScreenState();
}

class _AnalitikScreenState extends State<AnalitikScreen> {
  int selectedTab = 0; // 0 = Mingguan, 1 = Bulanan

  /// 🔥 DATA DUMMY (NANTI BISA DARI API)
  final List<double> dataMingguan = [300, 450, 380, 520, 600, 480, 580];
  final List<double> dataBulanan = [500, 700, 650, 800, 900, 750, 880];

  @override
  Widget build(BuildContext context) {
    final data = selectedTab == 0 ? dataMingguan : dataBulanan;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =======================================================
              /// 🔥 HEADER
              /// =======================================================
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

              /// =======================================================
              /// 🔥 STAT CARD
              /// =======================================================
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: const [
                  StatCard(
                    Icons.inventory_2,
                    "12",
                    "Total Produk",
                    "10 aktif",
                    Colors.green,
                  ),
                  StatCard(
                    Icons.remove_red_eye,
                    "15.7k",
                    "Total Dilihat",
                    "+12%",
                    Colors.blue,
                  ),
                  StatCard(
                    Icons.favorite_border,
                    "892",
                    "Total Favorit",
                    "+8%",
                    Colors.pink,
                  ),
                  StatCard(
                    Icons.star_border,
                    "4.8",
                    "Rating",
                    "dari 5.0",
                    Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// =======================================================
              /// 🔥 CHART
              /// =======================================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: boxStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE + TAB
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grafik Penayangan",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        /// TAB SWITCH
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xffF1F2F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              tabItem("Mingguan", 0),
                              tabItem("Bulanan", 1),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔥 REAL CHART
                    SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,

                          barTouchData: BarTouchData(enabled: true),

                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    "Sen",
                                    "Sel",
                                    "Rab",
                                    "Kam",
                                    "Jum",
                                    "Sab",
                                    "Min",
                                  ];
                                  return Text(
                                    days[value.toInt()],
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),

                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),

                          barGroups: List.generate(data.length, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: data[index],
                                  width: 18,
                                  gradient: const LinearGradient(
                                    colors: [Colors.green, Colors.blue],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            );
                          }),
                        ),
                        swapAnimationDuration: const Duration(
                          milliseconds: 400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =======================================================
              /// 🔥 DISTRIBUSI
              /// =======================================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: boxStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Distribusi Kategori",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),

                    ProgressItem("Pertanian", 0.57, Colors.green),
                    SizedBox(height: 12),
                    ProgressItem("Perikanan", 0.27, Colors.blue),
                    SizedBox(height: 12),
                    ProgressItem("Umum", 0.16, Colors.purple),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =======================================================
              /// 🔥 PRODUK TERLARIS
              /// =======================================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: boxStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Performa Produk",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),

                    ProductItem(
                      1,
                      "assets/beras.jpg",
                      "Beras Premium",
                      "2.450",
                      "89",
                      "4.8",
                    ),
                    ProductItem(
                      2,
                      "assets/cabai.jpg",
                      "Cabai Merah",
                      "1.340",
                      "67",
                      "4.7",
                    ),
                    ProductItem(
                      3,
                      "assets/sayur.jpg",
                      "Sayur Organik",
                      "2.100",
                      "145",
                      "4.7",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 TAB SWITCH
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
        child: Text(text, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

/// =======================================================
/// 🔥 STYLE
/// =======================================================
BoxDecoration boxStyle() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        blurRadius: 10,
        offset: const Offset(0, 4),
        color: Colors.black.withOpacity(0.05),
      ),
    ],
  );
}

/// =======================================================
/// 🔥 STAT CARD
/// =======================================================
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value, title, subtitle;
  final Color color;

  const StatCard(
    this.icon,
    this.value,
    this.title,
    this.subtitle,
    this.color, {
    super.key,
  });

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
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12)),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🔥 PROGRESS BAR
/// =======================================================
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
          children: [Text(title), Text("${(value * 100).toInt()}%")],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// 🔥 PRODUCT ITEM
/// =======================================================
class ProductItem extends StatelessWidget {
  final int rank;
  final String image, title, views, likes, rating;

  const ProductItem(
    this.rank,
    this.image,
    this.title,
    this.views,
    this.likes,
    this.rating, {
    super.key,
  });

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
          Text("$rank", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image, width: 45, height: 45, fit: BoxFit.cover),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
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
              const Icon(Icons.star, size: 16, color: Colors.orange),
              Text(rating),
            ],
          ),
        ],
      ),
    );
  }
}
