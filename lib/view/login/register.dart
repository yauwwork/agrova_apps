import 'package:agrova_apps/database/database_helper.dart';
import 'package:agrova_apps/extension/colors/appcolors.dart';
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
  final waController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  void registerUser() async {
    if (passwordController.text != konfirmasiController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password tidak sama")));

      return;
    }

    await DatabaseHelper.instance.insertUser({
      "nama": namaController.text,
      "email": emailController.text,
      "wa": waController.text,
      "password": passwordController.text,
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Akun berhasil dibuat")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Loginscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.oceanBlue,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.oceanBlue.withOpacity(0.5),
              AppColors.warmWhite,
              AppColors.mintGreen.withOpacity(0.5),
            ],
          ),
        ),

        //KOTAK PUTIH
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Buat Akun",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    fontSize: 36,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Mohon Isi Data Diri Anda Dengan Benar",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 32),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),

                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     hintText: "Isi Dengan Nama Lengkap Anda",
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.3),
                    //     border: InputBorder.none,
                    //   ),
                    // ),

                    // SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: namaController,
                        decoration: InputDecoration(
                          hintText: "Isi Dengan Nama Lengkap Anda",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Harap Masukan Email Anda",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Nomor WA",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: waController,
                        decoration: InputDecoration(
                          hintText: "Harap Masukan Nomor WA",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password (Minimal 8 Karakter)",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
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
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Konfirmasi Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: konfirmasiController,
                        decoration: InputDecoration(
                          hintText: "Ulangi Password untuk Konfirmasi",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
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
                    ),

                    SizedBox(height: 56),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.oceanBlue,
                            ),
                            onPressed: () {
                              registerUser();
                            },
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
