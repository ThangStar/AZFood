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
  int? idOrdersItem;
  int? idSizeCurrent;

  Product(
      {this.dvtName,
      required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.status,
      required this.quantity,
      this.imageUrl,
      this.idOrdersItem,
      this.idSizeCurrent,
      this.amountCart = 1});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      category: json["category"],
      status: json["status"],
      quantity: json["quantity"],
      dvtName: json["dvt_name"],
      idOrdersItem: json["idOrdersItem"],
      idSizeCurrent: json["idSizeCurrent"],
      imageUrl: json['imgUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dvt_name": dvtName,
        "price": price,
        "category": category,
        "status": status,
        "quantity": quantity,
        "imgUrl": imageUrl,
        "idOrdersItem": idOrdersItem,
        "idSizeCurrent": idSizeCurrent
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
            idOrdersItem == other.idOrdersItem &&
            idSizeCurrent == other.idSizeCurrent &&
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
      idOrdersItem.hashCode ^
      idSizeCurrent.hashCode ^
      dvtName.hashCode;

  Product copyWith({
    int? id,
    String? name,
    int? price,
    int? category,
    int? status,
    int? quantity,
    String? imageUrl,
    int? amountCart,
    String? dvtName,
    int? idOrdersItem,
    int? idSizeCurrent,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      amountCart: amountCart ?? this.amountCart,
      dvtName: dvtName ?? this.dvtName,
      idOrdersItem: idOrdersItem ?? this.idOrdersItem,
      idSizeCurrent: idSizeCurrent ?? this.idSizeCurrent,
    );
  }
}
