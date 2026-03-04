import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';

class BuatAkun extends StatefulWidget {
  const BuatAkun({super.key});

  @override
  State<BuatAkun> createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brightGreen.withOpacity(0.5),
              AppColors.warmWhite,
              AppColors.oceanBlue.withOpacity(0.5),
            ],
          ),
        ),

        //KOTAK PUTIH
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 700,
                width: 350,
                decoration: BoxDecoration(
                  color: AppColors.warmWhite.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warmWhite),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        "Buat Akun",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: AppColors.darkBackground,
                        ),
                      ),

                      Text(
                        "Daftar akun agrova baru",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.darkBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
