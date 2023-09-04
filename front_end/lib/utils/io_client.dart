import 'package:restaurant_manager_app/constants/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IoClient {
  late IO.Socket io;
  String token = 'token client';

  IoClient() {
    io = IO.io(
        Env.BASE_URL,
        IO.OptionBuilder()
            .disableAutoConnect()
            .setExtraHeaders({'token': token}).build());
    io.connect();
    io.onConnect((data) {
      print('connected socket');
    });
  }
}

IO.Socket io = IoClient().io;
