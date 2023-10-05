import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

import '../../utils/response.dart';

class TableApi {
  static Future<Object> updateStatus(int status, int idTable) async {
    print('status: $status idTable: $idTable');
    try {
      Response<dynamic> response = await http.post(Router.updateStatusTable,
          data: {'id': idTable, 'status': status});
      if (response.statusCode == 200) {
        print("OK! updateStatus ${response.data}");
        return Success(response: response, statusCode: response.statusCode);
      } else {
        print("failure updateStatus ${response.data}");
        return Failure(response: response, statusCode: response.statusCode);
      }
    } on DioException catch (err) {
      print("error updateStatus ${err.response}");
      return Failure(response: err.response);
    }
  }
}
