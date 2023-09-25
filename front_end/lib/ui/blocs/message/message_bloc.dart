import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/routers/socket.event.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
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
    on<TypingMessageEvent>(_typingMessageEvent);
    on<TypedMessageEvent>(_typedMessageEvent);
  }

  FutureOr<void> _initMessageEvent(
      InitMessageEvent event, Emitter<MessageState> emit) {
    emit(state.copyWith(msgs: event.msgs));
  }

  FutureOr<void> _actionSendMessage(
      ActionSendMessage event, Emitter<MessageState> emit) async {
    LoginResponse? prf = await MySharePreferences.loadProfile();
    if (prf != null) {
      event.msg.sendBy = prf.id;
      io.emit(SocketEvent.sendMsgToGroup, event.msg.toMap());
      emit(state.copyWith(msgs: [...state.msgs, event.msg]));
    }
  }

  FutureOr<void> _typingMessageEvent(
      TypingMessageEvent event, Emitter<MessageState> emit) {
    emit(state.copyWith(msgs: [
      ...state.msgs,
      Message(
          id: 0,
          sendBy: 1,
          type: 1,
          imageUrl: event.data['imgUrl'],
          statusMessage: StatusMessage.typing,
          profile: Profile(
            id: 0,
            name: event.data['name'],
          ))
    ]));
  }

  FutureOr<void> _typedMessageEvent(
      TypedMessageEvent event, Emitter<MessageState> emit) {
    List<Message> msg = state.msgs
        .where(
            (e) => e.id != event.id && e.statusMessage != StatusMessage.typing)
        .toList();
    emit(state.copyWith(msgs: msg));
  }
}
