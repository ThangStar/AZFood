import 'package:restaurant_manager_app/constants/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IoClient {
  late IO.Socket io;
  String token = 'token client';

  IoClient() {
    io = IO.io(
        Env.SOCKET_URL,
        IO.OptionBuilder()
            .setExtraHeaders({'token': token}).build());
    io.connect();
  }
}

IO.Socket io = IoClient().io;
