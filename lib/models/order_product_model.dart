class OrderProductModel {
  int productId;
  int quantity;
  int unitPrice;

  OrderProductModel({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
        productId: json['productId'],
        quantity: json['quantity'],
        unitPrice: json['unitPrice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}
