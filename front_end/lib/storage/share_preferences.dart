import 'package:shared_preferences/shared_preferences.dart';

class MySharePreferences {
  static Future<String?> loadSavedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }
}
