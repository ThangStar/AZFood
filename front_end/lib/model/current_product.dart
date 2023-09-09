import 'dart:convert';

CurrentProduct currentProductFromJson(String str) =>
    CurrentProduct.fromJson(json.decode(str));

String currentProductToJson(CurrentProduct data) => json.encode(data.toJson());

class CurrentProduct {
  int? orderId;
  DateTime? orderDate;
  int? totalAmount;
  int? productId;
  String? productName;
  int? dvt;
  int? quantity;
  int? subTotal;
  int? category;
  int? price;
  String? userName;

  CurrentProduct({
    this.orderId,
    this.orderDate,
    this.totalAmount,
    this.productId,
    this.productName,
    this.dvt,
    this.quantity,
    this.subTotal,
    this.category,
    this.price,
    this.userName,
  });

  factory CurrentProduct.fromJson(Map<String, dynamic> json) => CurrentProduct(
        orderId: json["orderID"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        totalAmount: json["totalAmount"],
        productId: json["productID"],
        productName: json["productName"],
        dvt: json["dvt"],
        quantity: json["quantity"],
        subTotal: json["subTotal"],
        category: json["category"],
        price: json["price"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "orderID": orderId,
        "orderDate": orderDate?.toIso8601String(),
        "totalAmount": totalAmount,
        "productID": productId,
        "productName": productName,
        "dvt": dvt,
        "quantity": quantity,
        "subTotal": subTotal,
        "category": category,
        "price": price,
        "userName": userName,
      };
}
