import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consultant/core/utils/app_colors.dart';
import 'package:osama_consultant/core/utils/assets.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/componetns.dart';
import '../widgets/filled_button.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var keyy = GlobalKey<FormState>();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0EBE7E), // Light blue color at the top
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5), // Light background color in the middle
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5), // Light background color in the middle
            Color(0xFFF5F5F5), // Light background color in the middle
            // Light background color in the middle
            Color(0xFF0EBE7E), // White color at the bottom
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
              SizedBox(
                height: 90.h,
              ),
              Text(AppStrings.signUPTxt1,
                  style: Theme.of(context).textTheme.displayLarge),
              Text(AppStrings.signUPTxt2,
                  style: Theme.of(context).textTheme.displayMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cusFilledButton(
                      icon: Assets.iconGoogle,
                      name: AppStrings.google,
                      onClick: () {
                        debugPrint('working');
                      }),
                  cusFilledButton(
                      icon: Assets.iconFacebook,
                      name: AppStrings.facebook,
                      onClick: () {
                        debugPrint('working');
                      }),
                ],
              ),
              Components.customTextField(
                hint: AppStrings.fullNameHint,
                controller: nameController,
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
              Row(
                children: [
                  Checkbox(
                    value: checked,
                    onChanged: (ch) {
                      setState(() {
                        checked = ch!;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Text(AppStrings.iAgree,
                      style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if ((keyy.currentState?.validate() ?? false) && checked) {
                    //event sign up
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
                    Navigator.of(context).pushReplacementNamed(Routes.signin);
                  },
                  child: Text(
                    AppStrings.alreadyHave,
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
