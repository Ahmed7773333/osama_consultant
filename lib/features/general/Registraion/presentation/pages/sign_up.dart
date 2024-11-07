// ignore_for_file: use_build_context_synchronously

import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/network/check_internet.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/componetns.dart';
import '../../../../../core/utils/get_itt.dart' as di;
import '../bloc/registraion_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var keyy = GlobalKey<FormState>();
  var _selectedCountry = CountryPickerUtils.getCountryByPhoneCode('1');
  bool checked = false;
  RegistraionBloc? bloc;
  @override
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => di.sl<RegistraionBloc>(),
      child: BlocConsumer<RegistraionBloc, RegistraionState>(
        listener: (context, state) async {
          if (state is SignUpError) {
            Navigator.pop(context);
            Components.showMessage(context,
                content: 'Check Your inputs again',
                icon: Icons.error,
                color: Colors.red);
          } else if (state is SigninError) {
            Navigator.pop(context);
            Components.showMessage(context,
                content: 'Wrong username or password',
                icon: Icons.error,
                color: Colors.red);
          } else if (state is AuthSuccess) {
            await UserPreferences.saveUserData(state.user.data!);
            final isAdmin = await UserPreferences.getIsAdmin();

            Navigator.pop(context);

            if (isAdmin == 0) {
              Navigator.of(context).pushReplacementNamed(Routes.homeLayout);
            } else {
              Navigator.of(context).pushReplacementNamed(Routes.homeLayoutAdmin,
                  arguments: {'page': 0});
            }
          } else if (state is AuthLoading || state is ResetPassLoading) {
            Components.circularProgressHeart(context);
          } else if (state is ResetPassError) {
            Navigator.pop(context);
            Components.showMessage(context,
                content: 'Wrong OTP', icon: Icons.error, color: Colors.red);
          } else if (state is ResetPassSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          bloc ??= RegistraionBloc.get(context);
          return Material(
            color: Colors.transparent,
            child: Form(
              key: keyy,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),

                    // SizedBox(height: 20.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     cusFilledButton(
                    //         icon: Assets.iconGoogle,
                    //         name: AppStrings.google,
                    //         onClick: () {
                    //           bloc.add(SignUpGoogleEvent());
                    //         }),
                    //     cusFilledButton(
                    //         icon: Assets.iconFacebook,
                    //         name: AppStrings.facebook,
                    //         onClick: () {}),
                    //   ],
                    // ),
                    SizedBox(height: 20.h),
                    Components.customTextField(
                      hint: localizations.fullNameHint,
                      controller: nameController,
                    ),
                    SizedBox(height: 20.h),
                    Components.customTextField(
                      hint: localizations.emailHint,
                      controller: emailController,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _openCountryPickerDialog,
                          child: Row(
                            children: [
                              CountryPickerUtils.getDefaultFlagImage(
                                  _selectedCountry),
                              SizedBox(width: 8.w),
                              Text('+${_selectedCountry.phoneCode}'),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        Components.customTextField(
                          hint: localizations.phoneHint,
                          controller: phoneController,
                          isPhone: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Components.customTextField(
                      hint: localizations.passwordHint,
                      controller: passwordController,
                      isPassword: true,
                      isShow: false,
                    ),
                    SizedBox(height: 20.h),
                    Components.customTextField(
                      hint: localizations.confirmedpasswordHint,
                      controller: confirmedpasswordController,
                      isPassword: true,
                      isShow: false,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (ch) {
                            setState(() {
                              checked = ch!;
                            });
                          },
                          activeColor: AppColors.secondry,
                        ),
                        Text(localizations.iAgree,
                            style: Theme.of(context).textTheme.displaySmall),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () async {
                        if ((keyy.currentState?.validate() ?? false) &&
                            checked) {
                          bool isConnect =
                              await ConnectivityService().getConnectionStatus();

                          if (isConnect) {
                            bloc!.add(SignUpEvent(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              '+${_selectedCountry.phoneCode}${phoneController.text}',
                              confirmedpasswordController.text,
                            ));
                          }

                          debugPrint('working');
                        } else {
                          debugPrint('error');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(295.w, 54.h)),
                      child: Text(
                        localizations.signUp,
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signIn,
                              arguments: {'bloc': bloc!});
                        },
                        child: Text(
                          localizations.alreadyHave,
                          style: AppStyles.redLableStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.r),
          searchCursorColor: Colors.black,
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text('Select your phone code'),
          onValuePicked: (country) {
            setState(() {
              _selectedCountry = country;
              debugPrint(_selectedCountry.phoneCode);
            });
          },
          itemBuilder: _buildDialogItem,
        ),
      ),
    );
  }

  Widget _buildDialogItem(country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.w),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.w),
          Flexible(child: Text(country.name))
        ],
      );
}
