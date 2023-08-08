class Success{
  final String data;
  final int? statusCode;
  Success({required this.data, this.statusCode = 201});
}

class Failure{
  final Object? dataErr;
  final int? statusCode;
  final String messageErr;

  //if status code is null => check by messageErr

  Failure( { this.dataErr, this.statusCode, this.messageErr = ""});
}