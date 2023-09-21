part of 'message_bloc.dart';

enum MessageStatus { initial, loading, success, failure }

class MessageState extends Equatable {
  const MessageState({
    required this.status,
    this.error,
    this.msgs = const []
  });

  final MessageStatus status;
  final String? error;
  final List<Message> msgs;

  @override
  List<Object?> get props => [status, error, msgs];

  MessageState copyWith({
    MessageStatus? status,
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