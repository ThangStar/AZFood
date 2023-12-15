// To parse this JSON data, do
//
//     final income = incomeFromJson(jsonString);

import 'dart:convert';

ProductPriceSize incomeFromJson(String str) => ProductPriceSize.fromJson(json.decode(str));

String incomeToJson(ProductPriceSize data) => json.encode(data.toJson());

class ProductPriceSize {
  int? id;
  String? sizeName;
  int? productId;
  int? productSize;
  int? productPrice;

  ProductPriceSize({
    this.id,
    this.sizeName,
    this.productId,
    this.productSize,
    this.productPrice,
  });

  factory ProductPriceSize.fromJson(Map<String, dynamic> json) => ProductPriceSize(
    id: json["id"],
    sizeName: json["size_name"],
    productId: json["product_id"],
    productSize: json["products_size"],
    productPrice: json["product_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size_name": sizeName,
    "product_id": productId,
    "products_size": productSize,
    "product_price": productPrice,
  };
}
