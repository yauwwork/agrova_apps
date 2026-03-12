import 'package:agrova_apps/extension/colors/appcolors.dart';
import 'package:flutter/material.dart';

class LupaPass extends StatefulWidget {
  const LupaPass({super.key});

  @override
  State<LupaPass> createState() => _LupaPassState();
}

class _LupaPassState extends State<LupaPass> {
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: 56),

                Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 90),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Masukan email untuk mereset password anda",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Harap Masukan Email Anda",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),

                SizedBox(height: 255),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.oceanBlue,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Reset Password",
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
}
