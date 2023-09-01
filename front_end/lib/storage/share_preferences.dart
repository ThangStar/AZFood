import 'package:restaurant_manager_app/constants/key_storages.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharePreferences {
  static Future<LoginResponse?> loadProfile() async {
    String key = KeyStorages.myProfile;
    final prefs = await SharedPreferences.getInstance();
    // print('data saved: ${prefs.getString(key)}');
    String result = prefs.getString(key) ?? "";
    return result.isEmpty ? null : LoginResponse.fromJson(result);
  }

  static Future<bool> saveProfile(String value) async {
    String key = KeyStorages.myProfile;
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }
}
