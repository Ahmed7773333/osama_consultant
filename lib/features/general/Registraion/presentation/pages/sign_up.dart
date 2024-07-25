// ignore_for_file: use_build_context_synchronously

import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/componetns.dart';
import '../../../../../core/utils/get_itt.dart' as di;
import '../bloc/registraion_bloc.dart';
import '../widgets/filled_button.dart';
import 'sign_in.dart';

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
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0EBE7E),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFFF5F5F5),
            Color(0xFF0EBE7E),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocProvider(
        create: (context) => di.sl<RegistraionBloc>(),
        child: BlocConsumer<RegistraionBloc, RegistraionState>(
          listener: (context, state) async {
            if (state is AuthError) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.l.message),
                ),
              );
              debugPrint(state.l.message);
            } else if (state is AuthSuccess) {
              await saveUserData(state.user.data!);
              final prefs = await SharedPreferences.getInstance();

              final isAdmin = prefs.getInt('is_admin');

              Navigator.pop(context);

              if (isAdmin == 0) {
                Navigator.of(context).pushReplacementNamed(Routes.homeLayout);
              } else {
                Navigator.of(context).pushReplacementNamed(
                    Routes.homeLayoutAdmin,
                    arguments: {'page': 0});
              }
            } else if (state is AuthLoading) {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Center(child: CircularProgressIndicator()),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            }
          },
          builder: (context, state) {
            RegistraionBloc bloc = RegistraionBloc.get(context);
            return Material(
              color: Colors.transparent,
              child: Form(
                key: keyy,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Text(AppStrings.signUPTxt1,
                          style: Theme.of(context).textTheme.displayLarge),
                      SizedBox(height: 20.h),
                      Text(AppStrings.signUPTxt2,
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cusFilledButton(
                              icon: Assets.iconGoogle,
                              name: AppStrings.google,
                              onClick: () {
                                bloc.add(SignInGoogleEvent());
                              }),
                          cusFilledButton(
                              icon: Assets.iconFacebook,
                              name: AppStrings.facebook,
                              onClick: () {
                                debugPrint('working');
                              }),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Components.customTextField(
                        hint: AppStrings.fullNameHint,
                        controller: nameController,
                      ),
                      SizedBox(height: 20.h),
                      Components.customTextField(
                        hint: AppStrings.emailHint,
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
                            hint: AppStrings.phoneHint,
                            controller: phoneController,
                            isPhone: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Components.customTextField(
                        hint: AppStrings.passwordHint,
                        controller: passwordController,
                        isPassword: true,
                        isShow: false,
                      ),
                      SizedBox(height: 20.h),
                      Components.customTextField(
                        hint: AppStrings.confirmedpasswordHint,
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
                          Text(AppStrings.iAgree,
                              style: Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          if ((keyy.currentState?.validate() ?? false) &&
                              checked) {
                            bloc.add(SignUpEvent(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              '+${_selectedCountry.phoneCode}${phoneController.text}',
                              confirmedpasswordController.text,
                            ));

                            debugPrint('working');
                          } else {
                            debugPrint('error');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(295.w, 54.h)),
                        child: Text(
                          AppStrings.signUp,
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
                                    builder: (c) => SignInPage(bloc)));
                          },
                          child: Text(
                            AppStrings.alreadyHave,
                            style: AppStyles.greenLableStyle,
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
