import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class OrderApi {
  static Future<List<Object>> create(
      List<ProductCheckOut> productCheckOuts, int userID) async {
    try {
      List<Future<Response<dynamic>>> reqs = productCheckOuts.map((e) {
        return http.post(Router.createOrder, data: {
          "productID": e.productID,
          "quantity": e.quantity,
          "userID": userID,
          "tableID": e.tableID
        });
      }).toList();

      List<Response<dynamic>> responses = await Future.wait(reqs);

      List<Object> responsesReturn = [];
      for (var e in responses) {
        if (e.statusCode == 200) {
          responsesReturn.add(Success(response: e, statusCode: e.statusCode));
        } else {
          print("failure order ${e.data}");
          responsesReturn.add(Failure(response: e, statusCode: e.statusCode));
        }
      }
      return responsesReturn;
    } on DioException catch (err) {
      print("error order ${err.response}");
      return [];
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
