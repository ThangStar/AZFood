import 'package:restaurant_manager_app/constants/env.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IoClient {
  late IO.Socket io;
  String token = 'token client';

  IoClient() {
    io = IO.io(
        Env.SOCKET_URL,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .setExtraHeaders({'token': token}).build());
    io.connect();
    io.onConnect((data){
      print("socket connected");
    });
  }
}

IO.Socket io = IoClient().io;
