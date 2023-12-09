import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class OrderApi {
  static Future<Object> create(
      ProductCheckOut productCheckOuts, int userID) async {
    try {
      Response<dynamic> response = await http.post(Router.createOrder, data: {
        "productID": productCheckOuts.productID,
        "quantity": productCheckOuts.quantity,
        "userID": userID,
        "tableID": productCheckOuts.tableID
      });
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure order ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
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
        print("failure  ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error  ${err.response}");
      return Failure(response: err.response);
    }
  }

  static Future<Object> payBill(tableID, payMethod) async {
    try {
      Response<dynamic> response = await http
          .post(Router.payBill, data: {"id": tableID, "payMethod": payMethod});
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure  ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error  ${err.response}");
      return Failure(response: err.response);
    }
  }

  static Future<Object> updateQuantity(
      {int? quantity,
      int? idOrderItems,
      required int productId,
      required int tableId,
      required TypeUpdateQuantity type}) async {
    try {
      Response<dynamic> response =
          await http.post(Router.updateQuantity, data: {
        "quantity": quantity,
        "productID": productId,
        "tableID": tableId,
        "type": type.name,
        "idOrderItems": idOrderItems
      });
      if (response.statusCode == 200) {
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure  ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error  ${err.response}");
      return Failure(response: err.response);
    }
  }
}

enum TypeUpdateQuantity { increment, decrement, set }
