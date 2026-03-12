import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VerifikasiSc extends StatefulWidget {
  const VerifikasiSc({super.key});

  @override
  State<VerifikasiSc> createState() => _VerifikasiScState();
}

class _VerifikasiScState extends State<VerifikasiSc> {
  int timeLeft = 120; // 2 menit
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime() {
    int minutes = timeLeft ~/ 60;
    int seconds = timeLeft % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

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

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 56),

                Text(
                  "Verifikasi Akun",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Kami telah mengirimkan kode verifikasi ke alamat email",
                    //Nanti emailnya diisi dengan email customer dan ditambah text button ganti disebelahnya
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 110),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kode Verifikasi",
                      style: TextStyle(fontSize: 14, fontFamily: "Inter"),
                    ),

                    timeLeft == 0
                        ? Text(
                            "Kirim ulang kode",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Inter",
                              color: AppColors.oceanBlue,
                            ),
                          )
                        : Text("Tunggu"),
                  ],
                ),

                SizedBox(height: 28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [otpBox(), otpBox(), otpBox(), otpBox()],
                ),

                SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kirim ulang kode dalam",
                      style: TextStyle(fontSize: 14, fontFamily: "Inter"),
                    ),

                    Text(
                      formatTime(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 72),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.oceanBlue,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Verifikasi Akun",
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
          ),
        ),
      ),
    );
  }

  Container otpBox() {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.charcoal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            // contentPadding: EdgeInsets.zero,
          ),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
