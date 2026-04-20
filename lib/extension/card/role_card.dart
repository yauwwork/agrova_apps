import 'dart:convert';
import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/models/user_models.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected; // 🔥 Menentukan apakah card aktif
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 🔥 Dijalankan saat diklik
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mintGreen.withOpacity(0.1) // 🔥 Warna kalau dipilih
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors
                      .mintGreen // 🔥 Border hijau kalau dipilih
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.mintGreen : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.mintGreen : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SellerCard extends StatelessWidget {
  final String userId;
  const SellerCard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModeFirebase?>(
      stream: FirebaseService.userStream(userId),
      builder: (context, snapshot) {
        // Tetap tampilkan loading singkat saat awal ambil data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final seller = snapshot.data;
        // Jika data seller null (misal user dihapus atau id tidak valid), 
        // kita tetap tampilkan Card dengan data fallback "Penjual Agrova"
        final String displayUsername = seller?.username ?? "Penjual Agrova";
        final String? photoBase64 = seller?.photoBase64;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.mintGreen.withOpacity(0.2), width: 2),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: photoBase64 != null
                      ? MemoryImage(base64Decode(photoBase64))
                      : const AssetImage(
                              "assets/images/gambarlain/download (1).jpg")
                          as ImageProvider,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayUsername,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.verified, size: 14, color: Colors.blue[400]),
                        const SizedBox(width: 4),
                        Text(
                          "Penjual Terpercaya",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mintGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  "Chat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

