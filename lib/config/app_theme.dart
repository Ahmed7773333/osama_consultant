import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary, //  variant of primary color
    scaffoldBackgroundColor:
        AppColors.background, //  background color for scaffold
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary, //  app bar color
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: AppStyles.welcomeSytle.copyWith(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 24.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.white70,
      ),
      displaySmall: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondry, //  input field background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white54),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      hintStyle: const TextStyle(
        color: Colors.white70,
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
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.secondry,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white70),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
    ).copyWith(secondary: AppColors.accent),
  );
}
