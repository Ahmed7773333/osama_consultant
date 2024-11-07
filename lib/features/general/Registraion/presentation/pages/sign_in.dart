// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/network/check_internet.dart';
import 'package:osama_consul/features/general/Registraion/presentation/widgets/enter_email.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/componetns.dart';
import '../bloc/registraion_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: Form(
        key: keyy,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90.h),
              Text(
                localizations.signInTxt1,
                style: Theme.of(context).textTheme.displayLarge,
              ),

              // SizedBox(height: 20.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     cusFilledButton(
              //       icon: Assets.iconGoogle,
              //       name: AppStrings.google,
              //       onClick: () {
              //         widget.bloc.add(SignInGoogleEvent());
              //       },
              //     ),
              //     cusFilledButton(
              //       icon: Assets.iconFacebook,
              //       name: AppStrings.facebook,
              //       onClick: () {},
              //     ),
              //   ],
              // ),
              SizedBox(height: 20.h),
              Components.customTextField(
                hint: localizations.emailHint,
                controller: emailController,
              ),
              SizedBox(height: 20.h),
              Components.customTextField(
                hint: localizations.passwordHint,
                controller: passwordController,
                isPassword: true,
                isShow: false,
                onPressed: () {},
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  if ((keyy.currentState?.validate() ?? false)) {
                    // Event sign in
                    bool isConnect =
                        await ConnectivityService().getConnectionStatus();
                    if (isConnect)
                      widget.bloc.add(SignInEvent(
                          emailController.text, passwordController.text));
                    debugPrint('working');
                  } else {
                    debugPrint('error');
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: Size(295.w, 54.h)),
                child: Text(
                  localizations.logIn,
                  style: AppStyles.buttonTextStyle,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => EmailEntryPage(widget.bloc)));
                  },
                  child: Text(
                    localizations.forget,
                    style: AppStyles.redLableStyle,
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
                    localizations.dontHave,
                    style: AppStyles.redLableStyle,
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
