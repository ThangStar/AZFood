// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant_manager_app/model/product.dart';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
    List<Product> data;
    int currentPage;
    int totalPages;
    int totalItems;

    ProductResponse({
        required this.data,
        required this.currentPage,
        required this.totalPages,
        required this.totalItems,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalItems: json["totalItems"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalItems": totalItems,
    };
}
