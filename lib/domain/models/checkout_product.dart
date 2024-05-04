class CheckOutProductModel {
  final String imageUrl;
  final String name;
  final int quantity;
  final double price;
  final int finalPrice;
  final String size;

  CheckOutProductModel(
      {required this.imageUrl,
      required this.name,
      required this.quantity,
      required this.price,
      required this.finalPrice,
      required this.size});
}
