part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class InitMessageEvent extends MessageEvent {
  final List<Message>? msgs;

<<<<<<< Updated upstream
  InitMessageEvent({this.msgs});
=======
  const InitMessageEvent({required this.msgs});
>>>>>>> Stashed changes
}

class ActionSendMessage extends MessageEvent{
  final Message msg;

  const ActionSendMessage({required this.msg});
}