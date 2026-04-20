import 'dart:convert';
import 'dart:io';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/user_models.dart';
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
      final data = await FirebaseService.getUserData(user.uid);
      if (data != null && data.photoBase64 != null) {
        setState(() {
          _currentPhotoBase64 = data.photoBase64;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_namaController.text.trim().isEmpty) {
      _showSnack("Nama tidak boleh kosong");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;
      if (user == null) return;

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
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showSnack("Gagal memperbarui profil: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (_currentPhotoBase64 != null
                          ? MemoryImage(base64Decode(_currentPhotoBase64!))
                          : null) as ImageProvider?,
                  child: _imageFile == null && _currentPhotoBase64 == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xff3B82F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
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
