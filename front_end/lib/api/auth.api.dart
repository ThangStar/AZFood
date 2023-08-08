import 'package:restaurant_manager_app/api/path.api.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

class Api{
  static Future<Object> login(){
    return Http().dio.post(Path.login);
  }
  static Future<Object> register(){
    return Http().dio.post(Path.register);
  }
}
