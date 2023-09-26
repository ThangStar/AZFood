import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/routers/socket.event.dart';
import 'package:restaurant_manager_app/utils/io_client.dart';

import '../../../model/message.dart';
import '../../../model/profile.dart';

part 'message_events.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc()
      : super(const MessageState(
          status: MessageStt.initial,
        )) {
    on<InitMessageEvent>(_initMessageEvent);
    on<ActionSendMessage>(_actionSendMessage);
  }

  FutureOr<void> _initMessageEvent(
      InitMessageEvent event, Emitter<MessageState> emit) {
    // final a = event.msgs as List<Message>;
    // emit(state.copyWith(msgs: a));
    List<Message> msgs = [
      Message(
          id: 1,
          sendBy: 2,
          message: "Adddwddwsdddddddddddwss ",
          type: 1,
          profile: Profile(
              id: 1,
              username: "username",
              password: "password",
              name: "name",
              role: "",
              phoneNumber: "phoneNumber",
              email: "email"))
    ];
    emit(state.copyWith(
      msgs: msgs
    ));
  }

  FutureOr<void> _actionSendMessage(ActionSendMessage event, Emitter<MessageState> emit) {
    io.emit(SocketEvent.sendMsgToGroup, event.msg.toMap());
  }
}
