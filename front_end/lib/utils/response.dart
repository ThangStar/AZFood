class Success{
  final String data;
  final int? statusCode;
  Success({required this.data, this.statusCode = 201});
}

class Failure{
  final String dataErr;
  final int? statusCode;

  Failure({required this.dataErr, this.statusCode = 404});
}