import 'package:restaurant_manager_app/constants/key_storages.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';

import '../model/login_result.dart';

class Auth {
  static Future<String> getTokenFromStorage() async {
    //do something
    LoginResult? rs =
        await MySharePreferences.loadSavedData(KeyStorages.myProfile);
    return rs != null ? rs.jwtToken : "";
  }
}
