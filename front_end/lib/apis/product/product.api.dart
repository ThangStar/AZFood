import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class ProductApi {
  static Future<Object> getProduct(int page) async {
    try {
      Response<dynamic> response = await http.get(Router.listProduct,
          queryParameters: {'page': page});
      if (response.statusCode == 200) {
        print(response);
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
}
