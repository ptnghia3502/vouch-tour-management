import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  late SharedPreferences _prefs;

  SharedPreferencesManager._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<void> logout1() async {
    await _prefs.remove('accounts');
  }

  static Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('access_token');
    await _prefs.remove('refreshToken');
    await _prefs.remove('role');
    await _prefs.remove('id');
    await _prefs.remove('emailCurrent');
  }

  // Thêm các phương thức khác tùy theo nhu cầu của bạn
}
