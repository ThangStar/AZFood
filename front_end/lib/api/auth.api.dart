import 'package:restaurant_manager_app/api/path.api.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

class AuthApi{
  static Future<Object> login(){
    return Http().dio.post(ApiPath.login);
  }
  static Future<Object> register(){
    return Http().dio.post(ApiPath.register);
  }
}
