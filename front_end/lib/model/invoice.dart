// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  int? id;
  int? total;
  DateTime? createAt;
  String? userName;
  int? tableId;
  String? tableName;

  Invoice({
    this.id,
    this.total,
    this.createAt,
    this.userName,
    this.tableId,
    this.tableName,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    total: json["total"],
    createAt: json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
    userName: json["userName"],
    tableId: json["tableID"],
    tableName: json["table_Name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "createAt": createAt?.toIso8601String(),
    "userName": userName,
    "tableID": tableId,
    "table_Name": tableName,
  };
}
