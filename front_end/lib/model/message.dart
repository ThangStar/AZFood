import 'package:restaurant_manager_app/model/profile.dart';

enum TypeMessage { text, message, voice }

class Message {
  final int id;
  final int sendBy;
  final int type;
  final Profile? profile;
  final String? message;

  Message(
      {required this.id,
      required this.sendBy,
      required this.type,
      this.message,
      this.profile});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'sendBy': this.sendBy,
      'type': this.type,
      'profile': this.profile,
      'message': this.message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      sendBy: map['sendBy'] as int,
      type: map['type'] as int,
      profile: map['profile'] as Profile,
      message: map['message'] as String,
    );
  }
}
