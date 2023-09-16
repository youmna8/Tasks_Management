import 'package:first_app/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme:
          AppBarTheme(backgroundColor: AppColors.background, centerTitle: true),
      textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
              color: AppColors.text, fontSize: 32.sp, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.lato(
            color: AppColors.text,
            fontSize: 16.sp,
          ),
          displaySmall: GoogleFonts.lato(
              color: AppColors.text.withOpacity(0.44), fontSize: 16.sp)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  ),
                 
                  ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    
                    hintStyle: GoogleFonts.lato(
            color: AppColors.text,
            fontSize: 16.sp,
          ),
                    fillColor: AppColors.textfield,
                    filled: true,
                  )
                  );
}
