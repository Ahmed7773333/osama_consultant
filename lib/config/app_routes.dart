import 'package:flutter/material.dart';
import 'package:osama_consultant/features/Registraion/presentation/pages/sign_up.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../features/Registraion/presentation/pages/sign_in.dart';
import '../features/splach_page.dart';

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String signin = 'login';
  static const String signUp = 'signUp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return MaterialPageRoute(builder: (_) => const SplachScreen());
      // case Routes.homeLayout:
      //   return MaterialPageRoute(builder: (_) => const HomeLayout());
      // case Routes.signin:
      //   return MaterialPageRoute(builder: (_) => const SignInPage());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      default:
        return unDefinedScreen();
    }
  }

  static Route<dynamic> unDefinedScreen() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.noRoute,
                  style: AppStyles.titleStyle,
                ),
              ),
              body: Center(
                child: Text(
                  AppStrings.noRoute,
                  style: AppStyles.titleStyle,
                ),
              ),
            ));
  }
}
