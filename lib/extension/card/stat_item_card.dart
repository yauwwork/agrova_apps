import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        /// 🔥 ICON
        Icon(icon, color: color),

        const SizedBox(height: 6),

        /// 🔥 VALUE
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1F2937), // AppColors.textPrimary fallback
          ),
        ),

        /// 🔥 LABEL
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white70 : const Color(0xFF6B7280), // AppColors.textSecondary fallback
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
