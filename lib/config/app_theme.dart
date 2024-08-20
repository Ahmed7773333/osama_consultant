import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary, // Light background color
    scaffoldBackgroundColor:
        AppColors.background, // Light background color for scaffold
    fontFamily: 'Roboto', // Adjust if another font is used in the design
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondry,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: AppStyles.welcomeSytle,
    ),
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
        backgroundColor: AppColors.secondry,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        textStyle: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.secondry,
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: AppColors.accent)
        .copyWith(surface: AppColors.background),
  );
}
