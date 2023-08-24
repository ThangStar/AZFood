import 'package:restaurant_manager_app/constants/key_storages.dart';
import 'package:restaurant_manager_app/model/login_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharePreferences {
  static Future<LoginResult?> loadProfile() async {
    String key = KeyStorages.myProfile;
    final prefs = await SharedPreferences.getInstance();
    print('data saved: ${prefs.getString(key)}');
    String result = prefs.getString(key) ?? "";
    return result.isEmpty ? null : LoginResult.fromJson(result);
  }

  static Future<bool> saveProfile(String value) async {
    String key = KeyStorages.myProfile;
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }
}
