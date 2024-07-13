// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cache/notification_service.dart';
import 'core/utils/my_bloc_observer.dart';
import 'my_app.dart';
import 'core/utils/get_itt.dart' as di;

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
