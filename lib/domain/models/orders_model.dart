class Order {
  final int id;
  final int addressId;
  final int paymentMethodId;
  final double finalPrice;
  final String orderStatus;

  Order({
    required this.id,
    required this.addressId,
    required this.paymentMethodId,
    required this.finalPrice,
    required this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      addressId: json['address_id'],
      paymentMethodId: json['payment_method_id'],
      finalPrice: json['final_price'].toDouble(),
      orderStatus: json['order_status'],
    );
  }
}
