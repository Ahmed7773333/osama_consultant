import 'package:shared_preferences/shared_preferences.dart';

import '../../features/general/Registraion/data/models/user_model.dart';

Future<void> saveUserData(Data userData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', userData.token ?? '');
  await prefs.setString('name', userData.name ?? '');
  await prefs.setString('email', userData.email ?? '');
  await prefs.setString('phone', userData.phone ?? '');

  await prefs.setInt('is_admin', userData.isAdmin ?? 0);
  await prefs.setString('created_at', userData.createdAt ?? '');
}

Future<void> removeUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('name');
  await prefs.remove('email');
  await prefs.remove('phone');

  await prefs.remove('is_admin');
  await prefs.remove('created_at');
  await prefs.remove('lengthOfMessages');
}
