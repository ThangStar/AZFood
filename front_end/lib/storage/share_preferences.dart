import 'package:restaurant_manager_app/model/login_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharePreferences {
  static Future<LoginResult?> loadSavedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      LoginResult rs = LoginResult.fromJson(prefs.getString(key) ?? '');
      return rs;
    }
    return null;
  }

  static Future<bool> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }
}
