import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';

class EditProduk extends StatefulWidget {
  final ProductModel produk;

  const EditProduk({super.key, required this.produk});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiController = TextEditingController();

  final picker = ImagePicker();

  List<File> images = [];
  List<String> existingImages = [];

  String kategori = "Buah-buahan";
  bool isLoading = false;

  final List<String> kategoriList = [
    "Buah-buahan",
    "Sayuran",
    "Ikan",
    "Daging",
    "Telur",
  ];

  @override
  void initState() {
    super.initState();

    final p = widget.produk;

    namaController.text = p.name;
    hargaController.text = p.price.toString();
    stokController.text = p.stock.toString();
    deskripsiController.text = p.description;
    lokasiController.text = p.location;
    kategori = p.category;

    /// 🔥 AMBIL IMAGE LAMA (AMAN)
    existingImages = (p.images).where((e) => e.isNotEmpty).toList();

    if (existingImages.isEmpty && p.imageBase64.isNotEmpty) {
      existingImages = [p.imageBase64];
    }
  }

  /// ================= PICK IMAGE =================
  Future<void> pickImages() async {
    int total = images.length + existingImages.length;

    if (total >= 5) {
      _snack("Maksimal 5 foto");
      return;
    }

    final picked = await picker.pickMultiImage(
      imageQuality: 20,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (picked.isEmpty) return;

    setState(() {
      int remaining = 5 - total;

      images.addAll(
        picked
            .take(remaining)
            .map((e) => File(e.path))
            .where((file) => file.existsSync()),
      );
    });
  }

  Future<String> toBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  /// ================= SAVE =================
  Future<void> simpanPerubahan() async {
    if (namaController.text.isEmpty ||
        hargaController.text.isEmpty ||
        stokController.text.isEmpty) {
      _snack("Isi semua field wajib");
      return;
    }

    setState(() => isLoading = true);

    try {
      List<String> finalImages = [];

      /// 🔥 EXISTING
      finalImages.addAll(existingImages.where((e) => e.isNotEmpty));

      /// 🔥 NEW
      for (var img in images) {
        final base64 = await toBase64(img);
        if (base64.isNotEmpty) {
          finalImages.add(base64);
        }
      }

      if (finalImages.isEmpty) {
        throw Exception("Minimal 1 gambar harus ada");
      }

      finalImages = finalImages.take(5).toList();

      await ProductService.updateProduct(widget.produk.id!, {
        "name": namaController.text.trim(),
        "category": kategori,
        "price": int.tryParse(hargaController.text) ?? 0,
        "stock": int.tryParse(stokController.text) ?? 0,
        "description": deskripsiController.text.trim(),
        "location": lokasiController.text.trim(),
        "images": finalImages,
        "imageBase64": finalImages.first,
      });

      _snack("Produk berhasil diupdate");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigatorPenjual()),
      );
    } catch (e) {
      _snack("Error: $e");
    }

    setState(() => isLoading = false);
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),

      /// ================= APPBAR =================
      appBar: AppBar(
        title: const Text("Edit Produk"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3B82F6), Color(0xff22C55E)],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= IMAGE =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3B82F6), Color(0xff22C55E)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Foto Produk (max 5)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...existingImages.asMap().entries.map(
                          (e) => _previewBase64(e.key),
                        ),
                        ...images.asMap().entries.map(
                          (e) => _previewFile(e.key),
                        ),
                        if ((images.length + existingImages.length) < 5)
                          _addButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= FORM =================
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _input(namaController, "Nama Produk"),
                  const SizedBox(height: 16),

                  /// 🔥 DROPDOWN (FIX SPACING)
                  DropdownButtonFormField(
                    value: kategori,
                    decoration: _decoration("Kategori"),
                    items: kategoriList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => kategori = v!),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _input(
                          hargaController,
                          "Harga",
                          type: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _input(
                          stokController,
                          "Stok",
                          type: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 🔥 DESKRIPSI (FIX MEPEt)
                  Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: deskripsiController,
                    maxLines: 4,
                    decoration: _decoration("Masukkan deskripsi produk"),
                  ),

                  const SizedBox(height: 16),

                  _input(lokasiController, "Lokasi"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= BUTTON =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: isLoading ? null : simpanPerubahan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff22C55E),
                  minimumSize: const Size.fromHeight(55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Simpan Perubahan"),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// ================= COMPONENT =================

  Widget _addButton() {
    return GestureDetector(
      onTap: pickImages,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _previewFile(int index) {
    return _imageBox(
      Image.file(images[index], fit: BoxFit.cover),
      () => setState(() => images.removeAt(index)),
    );
  }

  Widget _previewBase64(int index) {
    return _imageBox(
      Image.memory(base64Decode(existingImages[index]), fit: BoxFit.cover),
      () => setState(() => existingImages.removeAt(index)),
    );
  }

  Widget _imageBox(Widget img, VoidCallback onDelete) {
    return Stack(
      children: [
        Container(
          width: 90,
          margin: const EdgeInsets.only(right: 10),
          child: ClipRRect(borderRadius: BorderRadius.circular(16), child: img),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onDelete,
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
        ],
      ),
      child: child,
    );
  }

  Widget _input(
    TextEditingController c,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: c,
      keyboardType: type,
      decoration: _decoration(label),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xffF4F6FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ), // 🔥 FIX MEPEt
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}
