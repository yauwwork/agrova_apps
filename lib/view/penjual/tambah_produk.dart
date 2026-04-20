import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/product_model.dart';
import 'package:agrova_apps/services/product_service.dart';
import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _lokasiController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  /// 🔥 LIST FILE IMAGE (MAX 5)
  List<File> _images = [];

  String _kategori = "Buah-buahan";
  bool _isLoading = false;

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    _deskripsiController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  /// ================= PICK MULTI IMAGE =================
  Future<void> _pickImages() async {
    if (_images.length >= 5) {
      _showSnack("Maksimal 5 foto");
      return;
    }

    final List<XFile> picked = await _picker.pickMultiImage(
      imageQuality: 20,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (picked.isEmpty) return;

    setState(() {
      int remaining = 5 - _images.length;
      _images.addAll(picked.take(remaining).map((e) => File(e.path)));
    });
  }

  Future<String> _toBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> _submit() async {
    if (_isLoading) return;

    if (_namaController.text.isEmpty) {
      _showSnack("Nama produk wajib diisi");
      return;
    }

    if (_images.isEmpty) {
      _showSnack("Minimal 1 foto wajib");
      return;
    }

    setState(() => _isLoading = true);

    try {
      List<String> imagesBase64 = [];
      for (final img in _images) {
        final base64 = await _toBase64(img);
        imagesBase64.add(base64);
      }

      String firstImage = imagesBase64.first;

      final product = ProductModel(
        userId: "AUTO",
        name: _namaController.text,
        category: _kategori,
        price: int.tryParse(_hargaController.text) ?? 0,
        stock: int.tryParse(_stokController.text) ?? 0,
        description: _deskripsiController.text,
        location: _lokasiController.text,
        imageBase64: firstImage,
        images: imagesBase64,
      );

      await ProductService.addProduct(product);

      _showSnack("Produk berhasil ditambahkan");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigatorPenjual()),
      );
    } catch (e) {
      _showSnack("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Tambah Produk", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3B82F6), Color(0xff22C55E)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ================= FOTO =================
            _buildCard(
              title: "Foto Produk (max 5)",
              isDark: isDark,
              theme: theme,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _images.length + (_images.length < 5 ? 1 : 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  if (i == _images.length) {
                    return GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white12 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: isDark ? Border.all(color: Colors.white24) : null,
                        ),
                        child: Icon(Icons.add, color: isDark ? Colors.white70 : Colors.grey),
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _images[i],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _images.removeAt(i));
                          },
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.close, size: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// ================= FORM =================
            _buildCard(
              title: "Informasi Produk",
              isDark: isDark,
              theme: theme,
              child: Column(
                children: [
                  _input(_namaController, "Nama Produk", isDark: isDark),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: _kategori,
                    dropdownColor: isDark ? theme.cardColor : Colors.white,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: _inputDecoration("Kategori", isDark),
                    items: [
                      "Buah-buahan",
                      "Sayuran",
                      "Ikan",
                      "Daging",
                      "Telur",
                    ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => _kategori = v!),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _input(_hargaController, "Harga", number: true, isDark: isDark),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _input(_stokController, "Stok", number: true, isDark: isDark),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  _input(_deskripsiController, "Deskripsi", maxLines: 3, isDark: isDark),
                  const SizedBox(height: 10),
                  _input(_lokasiController, "Lokasi", isDark: isDark),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.skyBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Tambah Produk",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child, required bool isDark, required ThemeData theme}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
        border: isDark ? Border.all(color: Colors.white12) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController c,
    String hint, {
    bool number = false,
    int maxLines = 1,
    required bool isDark,
  }) {
    return TextField(
      controller: c,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: _inputDecoration(hint, isDark),
    );
  }

  InputDecoration _inputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
      filled: true,
      fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
