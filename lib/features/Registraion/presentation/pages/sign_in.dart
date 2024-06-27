// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osama_consultant/core/utils/assets.dart';
import 'package:osama_consultant/features/appointment.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/componetns.dart';
import '../widgets/filled_button.dart';
import '../widgets/forget_password_bottom_sheet.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var keyy = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount? _currentGoogleUser;
  AccessToken? _facebookAccessToken;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentGoogleUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // Future<void> _handleGoogleSignOut() async {
  //   await _googleSignIn.signOut();
  // }

  Future<void> _handleFacebookSignIn() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      setState(() {
        _facebookAccessToken = result.accessToken;
      });
    } else {
      debugPrint(result.status.toString());
      debugPrint(result.message);
    }
  }

  // Future<void> _handleFacebookSignOut() async {
  //   await FacebookAuth.instance.logOut();
  //   setState(() {
  //     _facebookAccessToken = null;
  //   });
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
                    onClick: _handleGoogleSignIn,
                  ),
                  cusFilledButton(
                    icon: Assets.iconFacebook,
                    name: AppStrings.facebook,
                    onClick: _handleFacebookSignIn,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppointmentPage()));
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
    );
  }
}
