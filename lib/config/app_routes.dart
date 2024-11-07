import 'package:flutter/material.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/pages/requests_page.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/pages/chat_screen.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/home_layout_admin.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/pages/mettings_control.dart';
import 'package:osama_consul/features/general/Registraion/presentation/bloc/registraion_bloc.dart';
import 'package:osama_consul/features/general/on_boarding.dart';
import 'package:osama_consul/features/user/Edit%20Profile/presentation/pages/edit_profile_page.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/pages/about.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/my_requests.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/request_details.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../core/utils/app_animations.dart';
import '../features/general/Chat Screen/data/models/chat_model.dart';
import '../features/general/Registraion/presentation/pages/sign_in.dart';
import '../features/user/HomeLayout/presentation/pages/home_layout.dart';
import '../features/general/Registraion/presentation/pages/sign_up.dart';
import '../features/splach_page.dart';
import '../features/user/MyRequests/presentation/pages/visa_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String homeLayoutAdmin = 'homeAdmin';
  static const String chatScreenAdmin = 'chatScreenAdmin';
  static const String manageTimes = 'ManageTimes';
  static const String requestsPage = 'requestsPage';
  static const String visaScreen = 'visaScreen';
  static const String myRequests = 'myRequests';
  static const String paymentScren = 'paymentScren';
  static const String onboarding = 'onboarding';
  static const String about = 'about';

  static const String editProfile = 'editProfile';

  static const String signIn = 'login';
  static const String signUp = 'signUp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return RightRouting(const SplachScreen());
      case Routes.onboarding:
        return RightRouting(const OnBoardingPage());
      case Routes.signIn:
        final args = settings.arguments as Map<String, dynamic>;
        final i = args['bloc'] as RegistraionBloc;
        return LeftRouting(SignInPage(i));
      case Routes.homeLayout:
        final args = settings.arguments as Map<String, dynamic>?;
        final i = args?['page'] as int?;
        return RightRouting(HomeLayout(
          page: i ?? 0,
        ));
      case Routes.homeLayoutAdmin:
        final args = settings.arguments as Map<String, dynamic>;
        final i = args['page'] as int?;
        return RightRouting(HomeLayoutAdmin(i));
      case Routes.chatScreenAdmin:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as ChatModel;
        final fromAdmin = args['isadmin'] as bool;
        return BottomRouting(ChatScreen(id, fromAdmin));
      case Routes.signUp:
        return RightRouting(const SignUpPage());
      case Routes.manageTimes:
        return LeftRouting(const MettingsControl());

      case Routes.requestsPage:
        return TopRouting(const RequestsPage());
      case Routes.about:
        return TopRouting(const AboutOsama());
      case Routes.visaScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final cubit = args['cubit'] as MyrequestsCubit;
        final id = args['id'] as int;

        return RightRouting(VisaScreen(cubit, id));
      case Routes.myRequests:
        return TopRouting(const MyRequests());
      case Routes.editProfile:
        return TopRouting(EditProfilePage());
      case Routes.paymentScren:
        final args = settings.arguments as Map<String, dynamic>;
        final cubit = args['cubit'] as MyrequestsCubit;

        return RightRouting(RequestDetails(cubit));
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
