import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          Locale appLocale;
          if (state is LanguageChanged) {
            appLocale = Locale(state.language);
          } else {
            appLocale = const Locale('en');
          }
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
              locale: appLocale,
              onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
            ),
          );
        },
      ),
    );
  }
}
