// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/componetns.dart';
import '../bloc/registraion_bloc.dart';
import '../widgets/filled_button.dart';
import '../widgets/forget_password_bottom_sheet.dart';

class SignInArguments {
  final RegistraionBloc
      bloc; // Replace `YourBlocType` with the actual type of `bloc`

  SignInArguments(this.bloc);
}

class SignInPage extends StatefulWidget {
  const SignInPage(this.bloc, {super.key});
  final RegistraionBloc bloc;
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var keyy = GlobalKey<FormState>();

  // Replace `YourBlocType` with the actual type of `bloc`

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _handleGoogleSignOut() async {
  //   await _googleSignIn.signOut();
  // }

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 90.h),
                Text(
                  AppStrings.signInTxt1,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 20.h),
                Text(
                  AppStrings.signInTxt2,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cusFilledButton(
                      icon: Assets.iconGoogle,
                      name: AppStrings.google,
                      onClick: () {
                        widget.bloc.add(SignInGoogleEvent());
                      },
                    ),
                    cusFilledButton(
                      icon: Assets.iconFacebook,
                      name: AppStrings.facebook,
                      onClick: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Components.customTextField(
                  hint: AppStrings.emailHint,
                  controller: emailController,
                ),
                SizedBox(height: 20.h),
                Components.customTextField(
                  hint: AppStrings.passwordHint,
                  controller: passwordController,
                  isPassword: true,
                  isShow: false,
                  onPressed: () {},
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if ((keyy.currentState?.validate() ?? false)) {
                      // Event sign in
                      widget.bloc.add(SignInEvent(
                          emailController.text, passwordController.text));
                      debugPrint('working');
                    } else {
                      debugPrint('error');
                    }
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(295.w, 54.h)),
                  child: Text(
                    AppStrings.logIn,
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ForgotPasswordBottomSheet();
                        },
                      );
                    },
                    child: Text(
                      AppStrings.forget,
                      style: AppStyles.greenLableStyle,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.signUp);
                    },
                    child: Text(
                      AppStrings.dontHave,
                      style: AppStyles.greenLableStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
