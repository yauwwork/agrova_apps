import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      appBar: AppBar(backgroundColor: AppColors.darkOceanBlue),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [Icon(Amicons.flaticon_pyramid_rounded, size: 40)],
          ),
        ),
      ),
    );
  }
}
