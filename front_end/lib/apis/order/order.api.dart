import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class OrderApi {
  static Future<Object> create(productID, quantity, userID, tableID) async {
    try {
      Response<dynamic> response = await http.post(Router.createOrder, data: {
        "productID": productID,
        "quantity": quantity,
        "userID": userID,
        "tableID": tableID
      });
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure login ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error login ${err.response}");
      return Failure(response: err.response);
    }
  }

  static Future<Object> getOrderInTable(tableID) async {
    try {
      Response<dynamic> response =
          await http.get(Router.getOrderInTable, queryParameters: {
        "tableID": tableID,
      });
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure login ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error login ${err.response}");
      return Failure(response: err.response);
    }
  }
}
