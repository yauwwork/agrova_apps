import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:agrova_apps/services/firebase_service.dart';
import 'package:agrova_apps/view/login/lupapassword.dart';
import 'package:agrova_apps/view/login/pilihperanpage.dart';
import 'package:agrova_apps/view/login/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isObscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// 🔥 LOGIN FUNCTION
  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    /// 🔥 VALIDASI DASAR
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email & password wajib diisi")),
      );
      return;
    }

    try {
      /// 🔥 LOGIN FIREBASE
      final result = await FirebaseService.loginUser(
        email: email,
        password: password,
      );

      final user = result.user;

      /// 🔥 AMBIL DATA FIRESTORE (OPTIONAL TAPI BAGUS)
      final userData = await FirebaseService.getUserData(user!.uid);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLogin", true);
      await prefs.setString("uid", user.uid); // 🔥 simpan uid user

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login berhasil"),
          backgroundColor: Colors.green,
        ),
      );

      /// 🔥 NAVIGASI KE ROLE PAGE
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PilihPeranPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgpenjual,
      body: Stack(
        children: [
          /// 🔥 BULATAN (FIX: FULL KE BAWAH)
          Positioned(
            bottom: -150,
            left: -120,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -180,
            right: -120,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 🔥 HEADER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff3B82F6), Color(0xff22C55E)],
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Selamat datang kembali 👋",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 SPACER BIAR CARD TURUN (INI KUNCI NYA)
                  SizedBox(height: screenHeight * 0.1),

                  /// 🔥 CARD (NO TRANSFORM = ANTI NGATUNG)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// EMAIL
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.mail_outline),
                            filled: true,
                            fillColor: Colors.blue.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// PASSWORD
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
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

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => LupaPass()),
                              );
                            },
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(color: Color(0xff3B82F6)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: loginUser,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(0xff3B82F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text(
                              "Masuk",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => BuatAkun()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Belum punya akun? ",
                              children: [
                                TextSpan(
                                  text: "Daftar",
                                  style: TextStyle(
                                    color: Color(0xff3B82F6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/logo/Google__G__logo.svg.png",
                            width: 18,
                          ),
                          label: const Text("Masuk dengan Google"),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 160),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
