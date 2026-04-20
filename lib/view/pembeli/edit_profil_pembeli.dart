import 'dart:convert';
import 'dart:io';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilPembeli extends StatefulWidget {
  const EditProfilPembeli({super.key});

  @override
  State<EditProfilPembeli> createState() => _EditProfilPembeliState();
}

class _EditProfilPembeliState extends State<EditProfilPembeli> {
  final _namaController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  File? _imageFile;
  String? _currentPhotoBase64;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      _namaController.text = user.displayName ?? "";
      try {
        final data = await FirebaseService.getUserData(user.uid);
        if (data != null && data.photoBase64 != null && data.photoBase64!.isNotEmpty) {
          setState(() {
            _currentPhotoBase64 = data.photoBase64;
          });
        }
      } catch (e) {
        print("Error loading user data: $e");
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25, // Kompresi lebih tinggi agar base64 tidak terlalu besar
        maxWidth: 500,    // Batasi lebar
        maxHeight: 500,   // Batasi tinggi
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showSnack("Gagal mengambil gambar: $e");
    }
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_namaController.text.trim().isEmpty) {
      _showSnack("Nama tidak boleh kosong");
      return;
    }

    setState(() => _isLoading = true);

    try {
      Map<String, dynamic> updateData = {
        'username': _namaController.text.trim(),
      };

      if (_imageFile != null) {
        final bytes = await _imageFile!.readAsBytes();
        final base64String = base64Encode(bytes);
        updateData['photoBase64'] = base64String;
      }

      await FirebaseService.updateUserData(user.uid, updateData);
      
      _showSnack("Profil berhasil diperbarui");
      if (mounted) {
        // Beri sedikit delay agar user bisa melihat snackbar sebelum pindah
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) Navigator.pop(context);
        });
      }
    } catch (e) {
      _showSnack("Gagal memperbarui profil: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softMint,
      appBar: AppBar(
        title: const Text("Edit Profil"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3B82F6), Color(0xff22C55E)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_currentPhotoBase64 != null && _currentPhotoBase64!.isNotEmpty
                              ? MemoryImage(base64Decode(_currentPhotoBase64!))
                              : null) as ImageProvider?,
                      child: _imageFile == null && (_currentPhotoBase64 == null || _currentPhotoBase64!.isEmpty)
                          ? const Icon(Icons.person, size: 65, color: Colors.grey)
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xff3B82F6),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi Personal",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff22C55E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
