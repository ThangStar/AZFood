part of 'message_bloc.dart';

enum MessageStt { initial, loading, success, failure }

class MessageState extends Equatable {
  const MessageState({
    required this.status,
    this.error,
    this.msgs = const []
  });

  final MessageStt status;
  final String? error;
  final List<Message> msgs;

  @override
  List<Object?> get props => [status, error, msgs];

  MessageState copyWith({
    MessageStt? status,
    String? error,
    List<Message>? msgs,
  }) {
    return MessageState(
      status: status ?? this.status,
      error: error ?? this.error,
      msgs: msgs ?? this.msgs,
    );
  }
}