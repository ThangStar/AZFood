import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/api/path.api.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../utils/response.dart';


class AuthApi {

  static Future<Object> login(String username, String password) async {
    //if: u has assets token? => call api send asset token
    //else: send username + password call api and save asset token + refresh token

    //this is test:
    print("aaaaaaaaa: ${ApiPath.baseUrl + ApiPath.login}");

    try {
      Response<Object> response = await Dio().post(ApiPath.baseUrl + ApiPath.login,
          data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return Success(
            data: "${response.data}", statusCode: response.statusCode);
      } else {
        return Failure(dataErr: response.data, statusCode: response.statusCode);
      }
    } catch (err) {
      return Failure(messageErr: err.toString());
    }
    // return Http().dio.post(ApiPath.login);
  }

  static Future<Object> register() {
    return Http().dio.post(ApiPath.register);
  }
}
