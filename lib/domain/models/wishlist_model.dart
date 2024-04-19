class WishlistItem {
  final int userId;
  final int inventoryId;

  WishlistItem({required this.userId, required this.inventoryId});

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      userId: json['user_id'],
      inventoryId: json['inventory_id'],
    );
  }
}