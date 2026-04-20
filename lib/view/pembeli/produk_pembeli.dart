import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agrova_apps/models/product_model.dart';

class DetailProdukSc extends StatefulWidget {
  final ProductModel product;

  const DetailProdukSc({super.key, required this.product});

  @override
  State<DetailProdukSc> createState() => _DetailProdukScState();
}

class _DetailProdukScState extends State<DetailProdukSc> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 🔥 HANDLE MULTI IMAGE + FALLBACK (SUPER AMAN)
  List<String> getImages() {
    final p = widget.product;
    if (p.images.isNotEmpty) {
      return p.images;
    }
    if (p.imageBase64.isNotEmpty) {
      return [p.imageBase64];
    }
    return [];
  }

  /// 🔥 SAFE IMAGE BUILDER (ANTI CRASH)
  Widget buildImage(String base64) {
    try {
      return Image.memory(
        base64Decode(base64),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } catch (e) {
      return Container(
        color: Colors.grey[300],
        child: const Center(child: Icon(Icons.broken_image, size: 40)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final images = getImages();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ================= IMAGE =================
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                if (images.isNotEmpty)
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (i) {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    itemBuilder: (context, index) {
                      return buildImage(images[index]);
                    },
                  )
                else
                  Container(
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image, size: 60)),
                  ),

                /// GRADIENT (Bungkus IgnorePointer agar swipe tidak terhalang)
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                ),

                /// DOT INDICATOR
                if (images.length > 1)
                  Positioned(
                    bottom: 14,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        final active = index == currentIndex;

                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: active ? 10 : 6,
                            height: active ? 10 : 6,
                            decoration: BoxDecoration(
                              color: active ? Colors.white : Colors.white54,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                /// COUNTER
                if (images.length > 1)
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${currentIndex + 1}/${images.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// ================= TOP BUTTON =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleBtn(Icons.arrow_back, () {
                    Navigator.pop(context);
                  }),
                  Row(
                    children: [
                      _circleBtn(Icons.favorite_border, () {}),
                      const SizedBox(width: 8),
                      _circleBtn(Icons.share, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// ================= CONTENT =================
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.6,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HANDLE
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      /// BADGE
                      Row(
                        children: [
                          _badge(p.category, Colors.green),
                          const SizedBox(width: 8),
                          _badge("Terverifikasi", Colors.blue),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Rp ${p.price}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Stok: ${p.stock}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            p.location,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Deskripsi Produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        p.description,
                        style: TextStyle(color: Colors.grey[700], height: 1.5),
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
