class Product {
  int id;
  String name;
  int price;
  int category;
  int? status;
  int? quantity;
  String? imageUrl;
  int amountCart;

  Product(
      {required this.id,
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
      imageUrl: json['imgUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category": category,
        "status": status,
        "quantity": quantity,
        "imgUrl": imageUrl
      };
}
