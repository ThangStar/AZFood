import 'package:dio/dio.dart';

class Success{
  final Response response;
  final int? statusCode;
  Success({required this.response, this.statusCode = 201});
}

class Failure{
  final Response? response;
  final int? statusCode;

  Failure({required this.response, this.statusCode = 404});
}