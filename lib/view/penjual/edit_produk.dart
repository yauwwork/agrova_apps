import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/produk_models.dart';
import 'package:agrova_apps/database/produk_data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProduk extends StatefulWidget {
  final Produk produk;
  final int index;

  const EditProduk({super.key, required this.produk, required this.index});

  @override
  State<EditProduk> createState() => _EditProduk();
}

class _EditProduk extends State<EditProduk> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController hargaController = TextEditingController();

  final TextEditingController stokController = TextEditingController();

  final TextEditingController deskripsiController = TextEditingController();

  final TextEditingController lokasiController = TextEditingController();

  File? imageProduk;
  final ImagePicker picker = ImagePicker();

  Future<void> ambilFoto() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageProduk = File(pickedFile.path);
      });
    }
  }

  String kategori = "Buah-buahan";
  String kuantitas = "Kilogram";

  @override
  void initState() {
    super.initState();

    namaController.text = widget.produk.nama;
    hargaController.text = widget.produk.harga;
    stokController.text = widget.produk.stok;
    deskripsiController.text = widget.produk.deskripsi;
    lokasiController.text = widget.produk.lokasi;

    kategori = widget.produk.kategori;

    if (widget.produk.image.isNotEmpty) {
      imageProduk = File(widget.produk.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bgpenjual,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePenjualSc()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.skyBlue,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Edit Produk",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// FOTO PRODUK
              const Text(
                "Foto Produk",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const SizedBox(width: 12),

                  /// TAMBAH FOTO
                  GestureDetector(
                    onTap: ambilFoto,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.skyBlue.withOpacity(0.4),
                        ),
                      ),
                      child: imageProduk == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: AppColors.skyBlue,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Tambah",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                imageProduk!,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// NAMA PRODUK
              _label("Nama Produk"),
              _textField(namaController),

              const SizedBox(height: 16),

              /// KATEGORI
              _label("Kategori"),

              DropdownButtonFormField(
                value: kategori,
                items: const [
                  DropdownMenuItem(
                    value: "Buah-buahan",
                    child: Text("Buah-buahan"),
                  ),
                  DropdownMenuItem(value: "Sayuran", child: Text("Sayuran")),
                  DropdownMenuItem(value: "Ikan", child: Text("Ikan")),
                  DropdownMenuItem(value: "Daging", child: Text("Daging")),
                  DropdownMenuItem(value: "Telur", child: Text("Telur")),
                ],
                onChanged: (value) {
                  setState(() {
                    kategori = value!;
                  });
                },
                decoration: _inputDecoration(),
              ),

              const SizedBox(height: 16),

              /// HARGA + STOK
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Harga (/Kg)"),
                        _textField(hargaController, prefix: "Rp "),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_label("Stok"), _textField(stokController)],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// DESKRIPSI
              _label("Deskripsi"),
              TextField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: _inputDecoration(),
              ),

              const SizedBox(height: 20),

              /// LOKASI KEBUN
              _label("Lokasi"),
              TextField(
                controller: lokasiController,
                maxLines: 4,
                decoration: _inputDecoration(),
              ),

              const SizedBox(height: 24),

              /// TAMBAH PRODUK
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        daftarProduk[widget.index] = Produk(
                          nama: namaController.text,
                          kategori: kategori,
                          harga: hargaController.text,
                          stok: stokController.text,
                          deskripsi: deskripsiController.text,
                          image: imageProduk?.path ?? "",
                          lokasi: lokasiController.text,
                          penjual: "Petani Agrova",
                        );

                        Navigator.pop(context);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePenjualSc()),
                        );
                      },
                      label: Text(
                        "Edit Produk",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                        ),
                      ),
                      icon: Icon(Amicons.remix_edit, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.skyBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// FOTO ITEM
  Widget _fotoItem(String image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(image, width: 90, height: 90, fit: BoxFit.cover),
        ),

        Positioned(
          top: 4,
          right: 4,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            padding: const EdgeInsets.all(3),
            child: const Icon(Icons.close, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// LABEL
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// TEXTFIELD
  Widget _textField(TextEditingController controller, {String? prefix}) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(prefix: prefix),
    );
  }

  /// INPUT DECORATION
  InputDecoration _inputDecoration({String? prefix}) {
    return InputDecoration(
      prefixText: prefix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
