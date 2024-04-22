class CouponModel {
  final int id;
  final String name;
  final bool available;
  final int discountPercentage;
  final int minimumPrice;

  CouponModel({
    required this.id,
    required this.name,
    required this.available,
    required this.discountPercentage,
    required this.minimumPrice,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      name: json['name'],
      available: json['available'],
      discountPercentage: json['discount_percentage'],
      minimumPrice: json['minimum_price'] as int,
    );
  }
}
