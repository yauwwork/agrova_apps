import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agrova_apps/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel produk;
  final Future<void> Function(bool isFav)? onFavorite;
  final bool isFavorited;

  const ProductCard({
    super.key,
    required this.produk,
    this.onFavorite,
    this.isFavorited = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isFav;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorited;
  }

  @override
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    isFav = widget.isFavorited;
  }

  Future<void> _toggleFav() async {
    if (loading) return;

    setState(() {
      isFav = !isFav;
      loading = true;
    });

    try {
      await widget.onFavorite?.call(isFav);
    } catch (e) {
      setState(() => isFav = !isFav);
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.produk;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: p.imageBase64.isNotEmpty
                    ? Image.memory(
                        base64Decode(p.imageBase64),
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image),
                      ),
              ),

              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: _toggleFav,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: loading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name),
                Text("Rp ${p.price}",
                    style: const TextStyle(color: Colors.green)),
                Text(p.location,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}