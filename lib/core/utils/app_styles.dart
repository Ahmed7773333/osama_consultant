import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle welcomeSytle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: AppColors.textPrimary,
  );
  static TextStyle whiteLableStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.textPrimary,
  );
  static TextStyle redLableStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.accent,
  );
  static TextStyle blueLableStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.accent,
  );
  static TextStyle hintStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w300,
    fontFamily: 'Poppins',
    color: AppColors.textSecondary,
  );
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.background,
  );
  static TextStyle titleStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.accent,
  );
  static TextStyle erorStyle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.accent,
  );
  static TextStyle smallStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    fontFamily: 'Poppins',
    color: AppColors.textPrimary,
  );
  static TextStyle smallLableStyle = TextStyle(
    fontSize: 16.0.sp,
    color: Colors.black54,
  );
}
