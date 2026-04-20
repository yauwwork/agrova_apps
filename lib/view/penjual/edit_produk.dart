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

  File? imageFile;
  final picker = ImagePicker();

  String kategori = "Buah-buahan";

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
  }

  /// 🔥 PICK IMAGE
  Future<void> ambilFoto() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  /// 🔥 CONVERT IMAGE TO BASE64
  Future<String> convertToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Edit Produk"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// IMAGE
            GestureDetector(
              onTap: ambilFoto,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageFile != null
                    ? Image.file(imageFile!, fit: BoxFit.cover)
                    : const Icon(Icons.add_a_photo),
              ),
            ),

            const SizedBox(height: 16),

            /// FORM
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stokController,
              decoration: const InputDecoration(labelText: "Stok"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: lokasiController,
              decoration: const InputDecoration(labelText: "Lokasi"),
            ),

            const SizedBox(height: 20),

            /// BUTTON SAVE
            ElevatedButton(
              onPressed: () async {
                String base64Image = widget.produk.imageBase64;

                /// kalau user pilih gambar baru
                if (imageFile != null) {
                  base64Image = await convertToBase64(imageFile!);
                }

                await ProductService.updateProduct(
                  widget.produk.id!,
                  {
                    "name": namaController.text,
                    "category": kategori,
                    "price": int.parse(hargaController.text),
                    "stock": int.parse(stokController.text),
                    "description": deskripsiController.text,
                    "location": lokasiController.text,
                    "imageBase64": base64Image,
                  },
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BottomNavigatorPenjual(),
                  ),
                );
              },
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}