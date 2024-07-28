import 'package:shared_preferences/shared_preferences.dart';
import '../../features/general/Registraion/data/models/user_model.dart';

class UserPreferences {
  static const _keyToken = 'token';
  static const _keyId = 'id';
  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyPhone = 'phone';
  static const _keyIsAdmin = 'is_admin';
  static const _keyCreatedAt = 'created_at';
  static const _keyFcmToken = 'fcm_token';

  static Future<void> saveUserData(UserModel userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, userData.token ?? '');
    await prefs.setInt(_keyId, userData.id ?? -1);
    await prefs.setString(_keyName, userData.name ?? '');
    await prefs.setString(_keyEmail, userData.email ?? '');
    await prefs.setString(_keyPhone, userData.phone ?? '');
    await prefs.setInt(_keyIsAdmin, userData.isAdmin ?? 0);
    await prefs.setString(_keyCreatedAt, userData.createdAt ?? '');
    await prefs.setString(_keyFcmToken, userData.fcm ?? '');
  }

  static Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyId);
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPhone);
    await prefs.remove(_keyIsAdmin);
    await prefs.remove(_keyCreatedAt);
    await prefs.remove(_keyFcmToken);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyId);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhone);
  }

  static Future<int?> getIsAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyIsAdmin);
  }

  static Future<String?> getCreatedAt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCreatedAt);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFcmToken);
  }
}
