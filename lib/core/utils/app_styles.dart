import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle welcomeSytle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: AppColors.primary,
  );
  static TextStyle whiteLableStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.primary,
  );
  static TextStyle blueLableStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.accent,
  );
  static TextStyle hintStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    fontFamily: 'Poppins',
    color: AppColors.textSecondary,
  );
  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.background,
  );
  static TextStyle titleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.primary,
  );
  static TextStyle erorStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: Colors.red,
  );
  static TextStyle smallStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: 'Poppins',
    color: AppColors.primary,
  );
  static TextStyle smallLableStyle = TextStyle(
    fontSize: 16.0.sp,
    color: Colors.black54,
  );
}