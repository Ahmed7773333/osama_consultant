import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary, // Light background color
    scaffoldBackgroundColor:
        AppColors.background, // Light background color for scaffold
    fontFamily: 'Roboto', // Adjust if another font is used in the design

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 24.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.black54,
      ),
      displaySmall: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.black54),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      hintStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 16.0,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF00C853),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accent,
        textStyle: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: AppColors.accent)
        .copyWith(surface: AppColors.background),
  );
}
