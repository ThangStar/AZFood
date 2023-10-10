import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class ProfileApi {
  static Future<Object> getProfile(int id, String token) async {
    try {
      Response<dynamic> response = await http.get(Router.profileDetail,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {'id': id});
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error  ${err.response}");
      return Failure(response: err.response);
    }
    // return Http().dio.post(ApiPath.login);
  }

  static Future<Object> updatePassword(String oldPassword, String newPassword) async {
    try {
      Response<dynamic> response = await http.post(Router.updatePassword, data: {
        'oldPassword': oldPassword,
        'password': newPassword,
      });

      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error  ${err.response}");
      return Failure(response: err.response);
    }
  }
}
