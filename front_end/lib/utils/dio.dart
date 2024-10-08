import 'package:dio/dio.dart';
import 'package:restaurant_manager_app/constants/env.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/routers/router.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/utils/response.dart';

class Http {
  late Dio dio;
  late String token;

  Http() {
    dio = Dio(BaseOptions(
        baseUrl: Env.BASE_URL ?? "http://localhost:8080",
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10)));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          LoginResponse? loginResult = await MySharePreferences.loadProfile();
          // print("token ${loginResult?.jwtToken}");
          if (loginResult != null) {
            token = loginResult.jwtToken;
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Access-Control-Allow-Origin'] = '*';
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          print("LỖI REQUEST $e");
          return handler.next(e);
        },
      ),
    );
  }

  void relogin() async {
    //login to twice -> failed -> navigate to login
    try {
      var response = await dio.post(Router.login,
          data: {"username": "trung1234", "password": "123123"});
      print("OK: $response");
    } catch (err) {
      print("ERROR: $err");
    }
  }

  Object handleRefreshToken() async {
    Response response = Response(requestOptions: RequestOptions());
    try {
      response = await dio.post('/url-refreshToken', data: {token: token});
      return response.statusCode == 200 || response.statusCode == 201
          ? Success(response: response, statusCode: response.statusCode)
          : Failure(response: response, statusCode: response.statusCode);
    } catch (err) {
      return Failure(response: response);
    }
  }
}

//how to use
//final response = await http.get('https://your-api.com/endpoint');

Dio http = Http().dio;
