import 'package:flutter/material.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/pages/requests_page.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/pages/chat_screen.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/home_layout_admin.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/pages/mettings_control.dart';
import 'package:osama_consul/features/general/settings/presentation/pages/settings_screen.dart';
import 'package:osama_consul/features/user/MyRequests/data/models/all_meeting_response.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/my_requests.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/payment_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../features/admin/Home Layout Admin/data/models/chat_model.dart';
import '../features/user/HomeLayout/presentation/pages/home_layout.dart';
import '../features/general/Registraion/presentation/pages/sign_up.dart';
import '../features/splach_page.dart';
import '../features/user/MyRequests/presentation/pages/visa_screen.dart';

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String homeLayoutAdmin = 'homeAdmin';
  static const String chatScreenAdmin = 'chatScreenAdmin';
  static const String manageTimes = 'ManageTimes';
  static const String settings = 'settings';
  static const String requestsPage = 'requestsPage';
  static const String visaScreen = 'visaScreen';
  static const String myRequests = 'myRequests';
  static const String paymentScren = 'paymentScren';

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
        return MaterialPageRoute(builder: (_) => const MettingsControl());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.requestsPage:
        return MaterialPageRoute(builder: (_) => const RequestsPage());
      case Routes.visaScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final cubit = args['cubit'] as MyrequestsCubit;
        return MaterialPageRoute(builder: (_) => VisaScreen(cubit));
      case Routes.myRequests:
        return MaterialPageRoute(builder: (_) => const MyRequests());
      case Routes.paymentScren:
        final args = settings.arguments as Map<String, dynamic>;
        final request = args['request'] as RequestModel;
        final cubit = args['cubit'] as MyrequestsCubit;

        return MaterialPageRoute(builder: (_) => PaymentScreen(request, cubit));
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
