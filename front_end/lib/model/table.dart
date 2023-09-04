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
  String? time;
  int? sumPrice;

  Table(
      {this.id,
      this.name,
      this.status,
      this.statusName,
      this.time,
      this.sumPrice});

  factory Table.fromJson(Map<String, dynamic> json) => Table(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      statusName: json["status_name"],
      time: json["time"],
      sumPrice: json["sum_price"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "status_name": statusName,
        "time": time,
        "sum_price": sumPrice
      };
}
