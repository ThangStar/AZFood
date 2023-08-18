import 'package:restaurant_manager_app/repository/path.api.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

class AuthApi{
  static Future<Object> login(){
    return http.post(ApiPath.login);
  }
  static Future<Object> register(){
    return http.post(ApiPath.register);
  }
}
