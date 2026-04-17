import 'package:agrova_apps/view/penjual/bottom_navigation_penjual.dart';
import 'package:flutter/material.dart';
import 'package:agrova_apps/models/produk_models.dart';
import 'package:agrova_apps/database/produk_data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProduk extends StatefulWidget {
  final Produk produk;
  final int index;

  const EditProduk({super.key, required this.produk, required this.index});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiController = TextEditingController();

  List<File> images = [];
  final picker = ImagePicker();

  String kategori = "Buah-buahan";

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
      images.add(File(widget.produk.image));
    }
  }

  Future<void> ambilFoto() async {
    if (images.length >= 5) return;

    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        images.add(File(file.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      /// 🔥 APPBAR CONSISTENT
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3B82F6), Color(0xff22C55E)],
            ),
          ),
        ),
        title: const Text(
          "Edit Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 FOTO
            _card(
              title: "Foto Produk",
              icon: Icons.image,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length + (images.length < 5 ? 1 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      if (index == images.length && images.length < 5) {
                        return GestureDetector(
                          onTap: ambilFoto,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.15),
                                  Colors.green.withOpacity(0.15),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.add, size: 30),
                          ),
                        );
                      }

                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${images.length}/5 foto",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔥 FORM
            _card(
              title: "Informasi Produk",
              icon: Icons.inventory_2,
              child: Column(
                children: [
                  _input(namaController, "Nama Produk"),
                  const SizedBox(height: 12),

                  DropdownButtonFormField(
                    value: kategori,
                    decoration: _dec("Kategori"),
                    items: const [
                      DropdownMenuItem(
                        value: "Buah-buahan",
                        child: Text("Buah-buahan"),
                      ),
                      DropdownMenuItem(
                        value: "Sayuran",
                        child: Text("Sayuran"),
                      ),
                      DropdownMenuItem(value: "Ikan", child: Text("Ikan")),
                      DropdownMenuItem(value: "Daging", child: Text("Daging")),
                      DropdownMenuItem(value: "Telur", child: Text("Telur")),
                    ],
                    onChanged: (v) => setState(() => kategori = v!),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _input(hargaController, "Harga", prefix: "Rp "),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _input(stokController, "Stok")),
                    ],
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: deskripsiController,
                    maxLines: 3,
                    decoration: _dec("Deskripsi"),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: lokasiController,
                    decoration: _dec("Lokasi"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  daftarProduk[widget.index] = Produk(
                    nama: namaController.text,
                    kategori: kategori,
                    harga: hargaController.text,
                    stok: stokController.text,
                    deskripsi: deskripsiController.text,
                    image: images.isNotEmpty ? images.first.path : "",
                    lokasi: lokasiController.text,
                    penjual: "Petani Agrova",
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BottomNavigatorPenjual(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3B82F6),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Simpan Perubahan"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 CARD
  Widget _card({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.blue),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, {String? prefix}) {
    return TextField(
      controller: c,
      decoration: _dec(hint, prefix: prefix),
    );
  }

  InputDecoration _dec(String hint, {String? prefix}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefix,
      filled: true,
      fillColor: Colors.grey[100],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
