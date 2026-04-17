import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:agrova_apps/view/login/loginpage.dart';
import 'package:flutter/material.dart';

class BuatAkun extends StatefulWidget {
  const BuatAkun({super.key});

  @override
  State<BuatAkun> createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  bool _isObscure = true;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  /// 🔥 REGISTER FIREBASE
  void registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = konfirmasiController.text.trim();
    final nama = namaController.text.trim();

    if (email.isEmpty || password.isEmpty || nama.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak sama"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password minimal 6 karakter"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseService.registerUser(
        email: email,
        password: password,
        username: nama,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Akun berhasil dibuat"),
          backgroundColor: AppColors.skyBlue,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception: ", ""))),
      );
    }
  }

  /// 🔥 INPUT STYLE (TETAP)
  InputDecoration inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      body: Stack(
        children: [
          /// 🔵 dekor atas
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.25),
                    Colors.blue.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// 🟢 dekor bawah
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.25),
                    Colors.green.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Buat Akun",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Isi data dengan benar untuk melanjutkan",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          color: Colors.black.withOpacity(0.06),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// NAMA
                        TextFormField(
                          controller: namaController,
                          decoration: inputStyle(
                            "Nama lengkap",
                            Icons.person_outline,
                          ),
                        ),
                        const SizedBox(height: 14),

                        /// EMAIL
                        TextFormField(
                          controller: emailController,
                          decoration: inputStyle("Email", Icons.mail_outline),
                        ),
                        const SizedBox(height: 14),

                        /// PASSWORD
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
                          decoration: inputStyle("Password", Icons.lock_outline)
                              .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                        ),
                        const SizedBox(height: 14),

                        /// KONFIRMASI
                        TextFormField(
                          controller: konfirmasiController,
                          obscureText: _isObscure,
                          decoration: inputStyle(
                            "Konfirmasi Password",
                            Icons.lock_outline,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3B82F6),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Buat Akun",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Loginscreen(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Sudah punya akun? ",
                          children: [
                            TextSpan(
                              text: "Masuk",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
