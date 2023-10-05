import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class ForgotPassApi {
  static Future<Object> forgotPassword(String email) async {
    try {
      Response<dynamic> response = await http.post(Router.sendEmail,
          data: {'email': email});
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure forgotPass ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error forgotPass ${err.response}");
      return Failure(response: err.response);
    }
    // return Http().dio.post(ApiPath.login);
  }
}
