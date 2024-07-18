import 'package:flutter/material.dart';
import 'package:osama_consul/features/Chat%20Screen/presentation/pages/chat_screen.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/home_layout_admin.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/pages/mettings_control.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../features/admin/Home Layout Admin/data/models/chat_model.dart';
import '../features/user/HomeLayout/presentation/pages/home_layout.dart';
import '../features/Registraion/presentation/pages/sign_up.dart';
import '../features/splach_page.dart';

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String homeLayoutAdmin = 'homeAdmin';
  static const String chatScreenAdmin = 'chatScreenAdmin';
  static const String manageTimes = 'ManageTimes';

  static const String signIn = 'login';
  static const String signUp = 'signUp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return MaterialPageRoute(builder: (_) => const SplachScreen());
      case Routes.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      case Routes.homeLayoutAdmin:
        final args = settings.arguments as Map<String, dynamic>;
        final i = args['page'] as int?;
        return MaterialPageRoute(builder: (_) => HomeLayoutAdmin(i));
      case Routes.chatScreenAdmin:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as ChatModel;
        final fromAdmin = args['isadmin'] as bool;
        return MaterialPageRoute(builder: (_) => ChatScreen(id, fromAdmin));
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case Routes.manageTimes:
        return MaterialPageRoute(builder: (_) => MettingsControl());
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
      ),
    );
  }
}
