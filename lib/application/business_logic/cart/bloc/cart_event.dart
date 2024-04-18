part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartAddingModel cart;

  AddToCartEvent({required this.cart});
}

class FetchCartEvent extends CartEvent {}

class DeleteFromCartEvent extends CartEvent {
  final int itemId;
  final int cartId;

  DeleteFromCartEvent({required this.cartId, required this.itemId});
}
