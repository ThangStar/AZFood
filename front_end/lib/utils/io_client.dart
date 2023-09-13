import 'package:restaurant_manager_app/constants/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IoClient {
  late IO.Socket io;
  String token = 'token client';
  static final IoClient _ioClient = IoClient._internal();
  IoClient._internal() {
    io = IO.io(
        Env.SOCKET_URL,
        IO.OptionBuilder()
            .disableAutoConnect()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .setExtraHeaders({'token': token}).build());
    io.connect();
    io.onConnect((data) {
      print("socket connected");
    });
  }
  factory IoClient() {
    return _ioClient;
  }
}

IO.Socket io = IoClient().io;
