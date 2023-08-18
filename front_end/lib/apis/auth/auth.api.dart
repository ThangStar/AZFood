import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/apis/path.api.dart';
import 'package:restaurant_manager_app/routers/auth.router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class AuthApi {
  static Future<Object> login(String username, String password) async {
    //if: u has assets token? => call api send asset token
    //else: send username + password call api and save asset token + refresh token
    try {
      Response<Object> response = await Http().dio.post(AuthRouter.login,
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        print(response.data);
        return Success(
            data: "${response.data}", statusCode: response.statusCode);
      } else {
        print("failure login ${response.data}");
        return Failure(dataErr: "response.data", statusCode: response.statusCode);
      }
    } catch (err) {
      print("error login $err");
      return Failure(dataErr: "err");
    }
    // return Http().dio.post(ApiPath.login);
  }

  static Future<Object> register() {
    return Http().dio.post(AuthRouter.register);
  }
}
