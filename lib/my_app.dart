import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'features/general/settings/presentation/bloc/settings_bloc.dart';

class MyApp extends StatelessWidget {
  static const MyApp _instance = MyApp._internal();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  factory MyApp() {
    return _instance;
  }

  const MyApp._internal();

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onStart: (index, key) {
        log('onStart: $index, $key');
      },
      onComplete: (index, key) {
        log('onComplete: $index, $key');
        if (index == 4) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          );
        }
      },
      blurValue: 1,
      autoPlayDelay: const Duration(seconds: 3),
      builder: (context) => BlocProvider(
        create: (_) => SettingsBloc()..add(InitSettingsEvent()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) => MaterialApp(
                navigatorKey: navigatorKey,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.themeData,
                locale: context.read<SettingsBloc>().isEnglish
                    ? const Locale('en')
                    : const Locale('ar'),
                onGenerateRoute: (settings) =>
                    RouteGenerator.getRoute(settings),
              ),
            );
          },
        ),
      ),
    );
  }
}
