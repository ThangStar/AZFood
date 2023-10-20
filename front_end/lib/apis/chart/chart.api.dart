import 'package:dio/dio.dart';

import '../../routers/router.dart';
import '../../utils/dio.dart';
import '../../utils/response.dart';

class ChartApi {
  static Future<Object> getIncomeAYear() async {
    try {
      Response<dynamic> response = await http.get(Router.inComeAMonth);
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure getIncomeAYear ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error getIncomeAYear ${err.response}");
      return Failure(response: err.response);
    }
  }
}
