// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/assets.dart';
import '../config/app_routes.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  Future<void> _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 0));
    if (!context.mounted) return;

    final token = await UserPreferences.getToken();
    final isAdmin = await UserPreferences.getIsAdmin();
    final firstTime = await UserPreferences.getFirstTime();
    debugPrint(firstTime.toString());
    if (firstTime ?? true) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    } else {
      if (token != null) {
        if (isAdmin == 0) {
          Navigator.of(context).pushReplacementNamed(Routes.homeLayout);
        } else {
          Navigator.of(context).pushReplacementNamed(
            Routes.homeLayoutAdmin,
            arguments: {'page': 0},
          );
        }
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.signUp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _navigateToHome(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          Assets.logo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
