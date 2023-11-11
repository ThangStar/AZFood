
import 'package:dio/dio.dart';

import '../../routers/router.dart';
import '../../utils/dio.dart';
import '../../utils/response.dart';

class CalendarApi {
  static Future<Object> attendance() async {
    try {
      Response<dynamic> response = await http.post(Router.attendance);
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure attendance ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error attendance ${err.response}");
      return Failure(response: err.response);
    }
  }
  static Future<Object> getHistory() async {
    try {
      Response<dynamic> response = await http.get(Router.history);
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure attendance history ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error attendance history ${err.response}");
      return Failure(response: err.response);
    }
  }
}