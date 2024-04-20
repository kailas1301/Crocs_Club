class OrderDetails {
  final int addressId;
  final int couponId;
  final int paymentId;
  final bool useWallet;
  final int userId;

  OrderDetails({
    required this.addressId,
    required this.couponId,
    required this.paymentId,
    required this.useWallet,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'coupon_id': couponId,
      'payment_id': paymentId,
      'use_wallet': useWallet,
      'user_id': userId,
    };
  }
}
