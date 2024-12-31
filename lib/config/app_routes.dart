import 'package:flutter/material.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/add_members.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/generate_code.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/push_notification.dart';
import 'package:osama_consul/features/general/Chat%20Screen/presentation/pages/chat_screen.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/pages/home_layout_admin.dart';
import 'package:osama_consul/features/general/Registraion/presentation/bloc/registraion_bloc.dart';
import 'package:osama_consul/features/user/Edit%20Profile/presentation/pages/edit_profile_page.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/pages/about.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/pages/enter_code.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/tabs/home.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/wallet_method.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_styles.dart';
import '../core/utils/app_animations.dart';
import '../features/general/Chat Screen/data/models/chat_model.dart';
import '../features/general/Registraion/presentation/pages/sign_in.dart';
import '../features/user/HomeLayout/presentation/pages/home_layout.dart';
import '../features/general/Registraion/presentation/pages/sign_up.dart';
import '../features/splach_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Routes {
  static const String splach = '/';
  static const String homeLayout = 'home';
  static const String homeLayoutAdmin = 'homeAdmin';
  static const String chatScreenAdmin = 'chatScreenAdmin';
  static const String visaScreen = 'visaScreen';
  static const String paymentScren = 'paymentScren';
  static const String about = 'about';

  static const String editProfile = 'editProfile';
  static const String home = 'Mainhome';
  static const String paymentMethods = 'paymentMethods';

  static const String cridetPay = 'cridetPay';
  static const String enterCode = 'enterCode';

  static const String signIn = 'login';
  static const String signUp = 'signUp';
  static const String pushNotification = 'pushNotification';
  static const String generateCode = 'generateCode';
  static const String addMembers = 'addMembers';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splach:
        return RightRouting(const SplachScreen());
      case Routes.home:
        return RightRouting(const HomeTab());
      case Routes.paymentMethods:
        final args = settings.arguments as Map<String, dynamic>?;
        final i = args?['is_ticket'] as bool?;
        return TopRouting(WalletMethod(i ?? true));

      // case Routes.cridetPay:
      //   return TopRouting(BuyConsultants());
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

      case Routes.about:
        return TopRouting(const AboutOsama());

      case Routes.editProfile:
        return TopRouting(EditProfilePage());
      case Routes.generateCode:
        return TopRouting(GenerateCode());
      case Routes.addMembers:
        final args = settings.arguments as Map<String, dynamic>;
        final i = args['bloc'] as HomeLayoutAdminBloc;
        return TopRouting(AddMembers(i));
      case Routes.pushNotification:
        final args = settings.arguments as Map<String, dynamic>;
        final i = args['bloc'] as HomeLayoutAdminBloc;
        return TopRouting(PushNotification(i));
      case Routes.enterCode:
        return TopRouting(EnterCode());

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
