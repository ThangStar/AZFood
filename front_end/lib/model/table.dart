// To parse this JSON data, do
//
//     final table = tableFromJson(jsonString);

import 'dart:convert';

Table tableFromJson(String str) => Table.fromJson(json.decode(str));

String tableToJson(Table data) => json.encode(data.toJson());

class Table {
  int? id;
  String? name;
  int? status;
  String? statusName;
  String? firstTime;
  int? sumPrice;

  Table(
      {this.id,
      this.name,
      this.status,
      this.statusName,
      this.firstTime,
      this.sumPrice});

  factory Table.fromJson(Map<String, dynamic> json) => Table(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      statusName: json["status_name"],
      firstTime: json["first_time"],
      sumPrice: json["total_amount"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "status_name": statusName,
        "first_time": firstTime,
        "total_amount": sumPrice
      };
}
