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
  static const _keyConsultantsCount = 'consultants_count';

  static const _firstTime = 'firstTime';
  static const _isEnglish = 'isEnglish';

  static const _isNotificationEnable = 'isNotificationEnable';
  static const showCase = 'showCase';

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
    await prefs.setInt(_keyConsultantsCount, userData.consultantCounter ?? 0);
  }

  static Future<void> updateNameAndPhone(String name, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyPhone, phone);
  }

  static Future<void> setConsultantCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyConsultantsCount, count);
  }

  static Future<void> enterFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTime, false);
  }

  static Future<void> setIsEnglish(bool i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isEnglish, i);
  }

  static Future<void> setShowCase() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(showCase, false);
  }

  static Future<bool?> getShowCase() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(showCase);
  }

  static Future<void> setIsNotificationEnabled(bool i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isNotificationEnable, i);
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

  static Future<bool?> getFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTime);
  }

  static Future<bool?> getIsEnglish() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isEnglish);
  }

  static Future<bool?> getIsNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isNotificationEnable);
  }

  static Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyId);
  }

  static Future<int?> getConsultantsCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyConsultantsCount);
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
