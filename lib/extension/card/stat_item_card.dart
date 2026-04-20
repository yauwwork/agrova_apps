import 'package:flutter/material.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatItem(
    this.icon,
    this.value,
    this.label,
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔥 ICON (SAMA PERSIS)
        Icon(icon, color: color),

        const SizedBox(height: 6),

        /// 🔥 VALUE
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        /// 🔥 LABEL
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}