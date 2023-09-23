import 'dart:async';

import 'package:chatview/chatview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_events.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc()
      : super(const MessageState(
          status: MessageStt.initial,
        )) {
    on<InitMessageEvent>(_initMessageEvent);
  }

  FutureOr<void> _initMessageEvent(
      InitMessageEvent event, Emitter<MessageState> emit) {
    final a = event.msgs as List<Message>;
    emit(state.copyWith(msgs: a));
  }
}
