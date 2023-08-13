import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String? BASE_URL = dotenv.env["BASE_URL"].toString();
  static String? SOCKET_URL = dotenv.env["SOCKET_URL"].toString();
}
