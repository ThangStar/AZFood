// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// status: 0 -> watting, 1 -> online, 2 -> error
class Table {
  final String tableName;
  final String? time;
  final int? sumPrice;
  final int status;

  Table({required this.tableName, required this.time, required this.sumPrice, required this.status});

  Table copyWith({
    String? tableName,
    String? time,
    int? sumPrice,
    int? status,
  }) {
    return Table(
      tableName: tableName ?? this.tableName,
      time: time ?? this.time,
      sumPrice: sumPrice ?? this.sumPrice,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tableName': tableName,
      'time': time,
      'sumPrice': sumPrice,
      'status': status,
    };
  }

  factory Table.fromMap(Map<String, dynamic> map) {
    return Table(
      tableName: map['tableName'] as String,
      time: map['time'] != null ? map['time'] as String : null,
      sumPrice: map['sumPrice'] != null ? map['sumPrice'] as int : null,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Table.fromJson(String source) => Table.fromMap(json.decode(source) as Map<String, dynamic>);
}
