import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    //BACKGROUND LOGIN
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      SizedBox(height: 24),

                      // GAMBAR LOGO
                      Image.asset(
                        "assets/images/logo/LOGO APPS1 (1).png",
                        width: 90,
                        height: 90,
                      ),

                      SizedBox(height: 16),

                      //TEKS HEADER
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "Masuk ke akun anda untuk melanjutkan",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 24),

                      //TEKS DAN TEKS FORM FIELD
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Masukan Email Anda",
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: AppColors.charcoal,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Password",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Masukan Password Anda",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColors.charcoal,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.charcoal,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                            ),

                            //LUPA PASSWORD BUTTON
                            Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Lupa Password?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.oceanBlue,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 12),

                            //MASUK DAN BUAT AKUN BUTTON
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.oceanBlue,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.warmWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.mintGreen,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Buat Akun",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.warmWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.darkBackground,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Atau masuk dengan",
                                    style: TextStyle(fontFamily: "Inter"),
                                  ),
                                ),

                                Expanded(
                                  child: Divider(
                                    color: AppColors.darkBackground,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            //BUTTON GOOGLE
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.warmWhite,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/logo/Google__G__logo.svg.png",
                                          width: 20,
                                          height: 20,
                                        ),

                                        SizedBox(width: 8),
                                        Text(
                                          "Google",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkCharcoal,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
