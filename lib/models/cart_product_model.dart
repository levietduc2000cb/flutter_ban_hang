class CartProductModel {
  int id;
  String name;
  int unitPrice;
  int quantity;
  int price;

  CartProductModel({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
        id: json['id'],
        name: json['name'],
        unitPrice: json['unitPrice'],
        quantity: json['quantity'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'price': price
    };
  }
}
