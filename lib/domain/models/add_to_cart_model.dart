class CartAddingModel {
  int productsId;
  int quantity;
  CartAddingModel({required this.productsId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'products_id': productsId,
      'quantity': quantity,
    };
  }
}
