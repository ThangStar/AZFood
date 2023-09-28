import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class InvoiceApi {
  static Future<Object> getAll() async {
    try {
      Response<dynamic> response =
          await http.get(Router.getAllInvoice, data: {});
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure invoice ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error invoice ${err.response}");
      return Failure(response: err.response);
    }
    // return Http().dio.post(ApiPath.login);
  }
}