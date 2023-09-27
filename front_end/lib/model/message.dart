import 'package:restaurant_manager_app/model/profile.dart';

enum TypeMessage { text, message, voice }
enum StatusMessage {typing, none}
class Message {
  final int id;
  int sendBy;
  final int type;
  final Profile? profile;
  final String? message;
  final String? raw;
  final String? imageUrl;
  final String? dateTime;
  StatusMessage statusMessage;

  Message({
    required this.id,
    required this.sendBy,
    required this.type,
    this.message,
    this.profile,
    this.raw,
    this.imageUrl,
    this.statusMessage = StatusMessage.none,
    // this.profile,
    this.dateTime,
  });

  Message copyWith({
    int? id,
    int? sendBy,
    int? type,
    Profile? profile,
    String? message,
    String? raw,
    String? imageUrl,
    String? dateTime,
  }) {
    return Message(
      id: id ?? this.id,
      sendBy: sendBy ?? this.sendBy,
      type: type ?? this.type,
      profile: profile ?? this.profile,
      message: message ?? this.message,
      raw: raw ?? this.raw,
      imageUrl: imageUrl ?? this.imageUrl,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sendBy': sendBy,
      'type': type,
      'message': message,
      'raw': raw,
      'imageUrl': imageUrl,
      'dateTime': dateTime,
      'profile': profile
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'] as int,
        sendBy: map['sendBy'] as int,
        type: map['type'] as int,
        message: map['message'] as String?,
        raw: map['raw'] as String?,
        imageUrl: map['imageUrl'] as String?,
        dateTime: map['dateTime'] as String?,
        profile: Profile.fromJson(map['profile']));
  }
}
