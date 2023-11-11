/// id : 10
/// userID : 7
/// date : "2023-09-25T08:00:00.000Z"
/// status : "đi làm"

class Attendance {
  Attendance({
    this.id,
    this.userID,
    this.date,
    this.status,
  });

  Attendance.fromJson(dynamic json) {
    id = json['id'];
    userID = json['userID'];
    date = json['date'];
    status = json['status'];
  }

  int? id;
  int? userID;
  String? date;
  String? status;

  Attendance copyWith({
    int? id,
    int? userID,
    String? date,
    String? status,
  }) =>
      Attendance(
        id: id ?? this.id,
        userID: userID ?? this.userID,
        date: date ?? this.date,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userID'] = userID;
    map['date'] = date;
    map['status'] = status;
    return map;
  }
}
