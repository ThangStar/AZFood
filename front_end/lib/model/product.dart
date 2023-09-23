class Product {
  int id;
  String name;
  int price;
  int category;
  int? status;
  int? quantity;
  String? imageUrl;
  int amountCart;
  String? dvtName;

  Product(
      {this.dvtName,
      required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.status,
      required this.quantity,
      this.imageUrl,
      this.amountCart = 1});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      category: json["category"],
      status: json["status"],
      quantity: json["quantity"],
      dvtName: json["dvt_name"],
      imageUrl: json['imgUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dvt_name": dvtName,
        "price": price,
        "category": category,
        "status": status,
        "quantity": quantity,
        "imgUrl": imageUrl
      };

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            price == other.price &&
            category == other.category &&
            status == other.status &&
            quantity == other.quantity &&
            imageUrl == other.imageUrl &&
            amountCart == other.amountCart &&
            dvtName == other.dvtName;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      price.hashCode ^
      category.hashCode ^
      status.hashCode ^
      quantity.hashCode ^
      imageUrl.hashCode ^
      amountCart.hashCode ^
      dvtName.hashCode;
}
