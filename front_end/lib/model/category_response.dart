// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant_manager_app/model/category.dart';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    List<Category> category;

    CategoryResponse({
        required this.category,
    });

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        category: List<Category>.from(json["resultRaw"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

