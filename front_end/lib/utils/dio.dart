import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/apis/path.api.dart';
import 'package:restaurant_manager_app/constants/env.dart';
import 'package:restaurant_manager_app/routers/auth.router.dart';
import 'package:restaurant_manager_app/utils/auth.dart';
import 'package:restaurant_manager_app/utils/response.dart';

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Access-Control-Allow-Origin'] = '*';
    super.onRequest(options, handler);
  }
}

class Http {
  late Dio dio;
  late String accessToken;
  late String refreshToken;
  Http() {
    dio = Dio(BaseOptions(
        baseUrl: Env.BASE_URL ?? "http://localhost:8080",
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10)));

    // accessToken = Auth.getAccessTokenFromStorage();
    // refreshToken = Auth.getRefreshTokenFromStorage();

    // if (accessToken.isEmpty) {
    //   if (refreshToken.isNotEmpty) {
    //     //Call API if u only has refresh token
    //     dio.interceptors.add(AuthInterceptor(refreshToken));
    //     final response = handleRefreshToken();
    //     response is Success
    //         ? print('request success!: ${response.data}')
    //         : print('request failure: ${response}');
    //   } else {
    //     //Haven't access + refresh token => close connect + back to login
    //     dio.close();
    //   }
    // } else {
    //   // dio.interceptors.add(AuthInterceptor(accessToken));
    //   callApi();
    // }
  }
  void callApi() async {
    try {
      var response = await dio.post(AuthRouter.login,
          data: {"username": "trung1234", "password": "123123"});
      print("OK: $response");
    } catch (err) {
      print("ERROR: $err");
    }
  }

  Object handleRefreshToken() async {
    Response response;
    try {
      response = await dio
          .post('/url-refreshToken', data: {refreshToken: refreshToken});
      return response.statusCode == 200 || response.statusCode == 201
          ? Success(data: response.data, statusCode: response.statusCode)
          : Failure(dataErr: response.data, statusCode: response.statusCode);
    } catch (err) {
      return Failure(dataErr: "response.data");
    }
  }
}

//how to use
//  final dio = Dio();
//     dio.interceptors.add(AuthInterceptor('your_jwt_token_here'));
//
//     final response = await dio.get('https://your-api.com/endpoint');
