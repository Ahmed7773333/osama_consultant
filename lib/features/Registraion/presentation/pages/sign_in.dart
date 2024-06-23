import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consultant/core/utils/assets.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/componetns.dart';
import '../widgets/filled_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var keyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0EBE7E), // Light blue color at the top
            Color(0xFFF5F5F5), // Light background color in the middle
            Color(0xFFF5F5F5), // Light background color in the middle
            Color(0xFFF5F5F5), // Light background color in the middle
            Color(0xFF0EBE7E), // Light background color at the bottom
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: Form(
          key: keyy,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 90.h),
              Text(
                AppStrings.signInTxt1,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                AppStrings.signInTxt2,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cusFilledButton(
                    icon: Assets.iconGoogle,
                    name: AppStrings.google,
                    onClick: () {
                      debugPrint('working');
                    },
                  ),
                  cusFilledButton(
                    icon: Assets.iconFacebook,
                    name: AppStrings.facebook,
                    onClick: () {
                      debugPrint('working');
                    },
                  ),
                ],
              ),
              Components.customTextField(
                hint: AppStrings.emailHint,
                controller: emailController,
              ),
              Components.customTextField(
                hint: AppStrings.passwordHint,
                controller: passwordController,
                isPassword: true,
                isShow: false,
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: () {
                  if ((keyy.currentState?.validate() ?? false)) {
                    // Event sign in
                    debugPrint('working');
                  } else {
                    debugPrint('error');
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: Size(295.w, 54.h)),
                child: Text(
                  AppStrings.signUp,
                  style: AppStyles.buttonTextStyle,
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ForgotPasswordBottomSheet();
                      },
                    );
                  },
                  child: Text(
                    AppStrings.forget,
                    style: AppStyles.whiteLableStyle,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.signUp);
                  },
                  child: Text(
                    AppStrings.dontHave,
                    style: AppStyles.whiteLableStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordBottomSheet extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forgot password',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your email for the verification process, we will send 4 digits code to your email.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 16.h),
          Components.customTextField(
            hint: 'Email',
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
                  return ResetPasswordBottomSheet();
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

class ResetPasswordBottomSheet extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();

  ResetPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
