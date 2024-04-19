part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class AddToWishlistEvent extends WishlistEvent {
  final int inventoryId;

  AddToWishlistEvent(this.inventoryId);
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final int inventoryId;

  RemoveFromWishlistEvent(this.inventoryId);
}

class FetchWishlistEvent extends WishlistEvent {}
