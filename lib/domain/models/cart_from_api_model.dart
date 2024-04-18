class CartItem {
  final int productId;
  final String productName;
  final int categoryId;
  final int quantity;
  final int price;
  final int totalPrice;

  CartItem({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      productName: json['product_name'],
      categoryId: json['category_id'],
      quantity: json['quantity'],
      price: json['price'],
      totalPrice: json['total_price'],
    );
  }
}

class CartFromApiModel {
  final int id;
  final List<CartItem> items;

  CartFromApiModel({
    required this.id,
    required this.items,
  });

  factory CartFromApiModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['Data'] ?? [];
    final List<CartItem> items =
        itemsJson.map((itemJson) => CartItem.fromJson(itemJson)).toList();
    return CartFromApiModel(
      id: json['ID'],
      items: items,
    );
  }
}
