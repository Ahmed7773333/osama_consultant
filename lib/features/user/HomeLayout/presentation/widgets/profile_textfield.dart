import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import 'show_edit.dart';

Widget customTextField(
  context, {
  IconData? icon,
  required TextEditingController controller,
  hint,
}) {
  return SizedBox(
    width: 335.w,
    height: 64.h,
    child: TextField(
      readOnly: true,
      style: AppStyles.hintStyle,
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: Icon(
            icon,
            size: 25.sp,
            color: AppColors.secondry,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              showEditProfileDialog(
                  context: context, controller: controller, hint: hint);
            },
            icon: Icon(
              Icons.edit,
              size: 25.sp,
              color: AppColors.secondry,
            ),
          )),
    ),
  );
}
