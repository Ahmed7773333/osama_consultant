import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consultant/core/utils/app_strings.dart';
import 'package:osama_consultant/core/utils/app_styles.dart';
import 'package:osama_consultant/core/utils/componetns.dart';

import 'reset_password_bottom_sheet.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.forget,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your email for the verification process, we will send 4 digits code to your email.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 16.h),
          Components.customTextField(
            hint: AppStrings.emailHint,
            controller: emailController,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              // Handle continue button press
              Navigator.pop(context); // Close the bottom sheet
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const ResetPasswordBottomSheet();
                },
              );
            },
            style: ElevatedButton.styleFrom(fixedSize: Size(295.w, 54.h)),
            child: Text(
              'Continue',
              style: AppStyles.buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
