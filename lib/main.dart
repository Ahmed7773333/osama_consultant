import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/my_bloc_observer.dart';
import 'my_app.dart';
// import 'core/utils/get_itt.dart' as di;

void main() async {
  // await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
