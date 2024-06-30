import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/assets.dart';
import '../config/app_routes.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  Future<void> _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!context.mounted) return;

    Navigator.of(context).pushReplacementNamed(Routes.signUp);
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
