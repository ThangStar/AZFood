// To parse this JSON data, do
//
//     final income = incomeFromJson(jsonString);

import 'dart:convert';

Income incomeFromJson(String str) => Income.fromJson(json.decode(str));

String incomeToJson(Income data) => json.encode(data.toJson());

class Income {
  int? year;
  int? month;
  int? totalAmount;

  Income({
    this.year,
    this.month,
    this.totalAmount,
  });

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        year: json["year"],
        month: json["month"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "total_amount": totalAmount,
      };
}
