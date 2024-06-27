import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/componetns.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController reEnterPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Reset Password',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'Set the new password for your account so you can login and access all the features.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 16.h),
          Components.customTextField(
            hint: 'New Password',
            controller: newPasswordController,
            isPassword: true,
          ),
          Components.customTextField(
            hint: 'Re-enter Password',
            controller: reEnterPasswordController,
            isPassword: true,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              // Handle update password button press
              Navigator.pop(context); // Close the bottom sheet
            },
            style: ElevatedButton.styleFrom(fixedSize: Size(295.w, 54.h)),
            child: Text(
              'Update Password',
              style: AppStyles.buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
