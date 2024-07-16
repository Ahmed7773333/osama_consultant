// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';

class MyApp extends StatelessWidget {
  static final MyApp _instance = MyApp._internal();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  factory MyApp() {
    return _instance;
  }

  MyApp._internal();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
      ),
    );
  }
}
