import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String BASE_URL = dotenv.env["BASE_URL"] ?? "http://localhost:8080";
  static String SOCKET_URL =
      dotenv.env["SOCKET_URL"] ?? "http://localhost:8080";
}
