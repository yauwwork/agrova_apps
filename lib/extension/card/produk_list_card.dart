import 'dart:io';

import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String subtitle;
  final String location;
  final double rating;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ListCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.subtitle,
    required this.location,
    required this.rating,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // FOTO PRODUK
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(widget.image),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),

          // INFO PRODUK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAMA PRODUK
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 4),

                // KATEGORI
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),

                SizedBox(height: 6),

                // HARGA
                Text(
                  widget.price,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // TOMBOL EDIT & DELETE
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: widget.onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
