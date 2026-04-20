import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrova_apps/services/theme_service.dart';

class PengaturanPenjual extends StatelessWidget {
  const PengaturanPenjual({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TAMPILAN",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.15),
                    child: Icon(
                      themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text("Dark Mode"),
                  subtitle: Text(
                    themeService.isDarkMode ? "Aktif" : "Nonaktif",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Switch(
                    value: themeService.isDarkMode,
                    onChanged: (value) {
                      themeService.toggleTheme();
                    },
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
