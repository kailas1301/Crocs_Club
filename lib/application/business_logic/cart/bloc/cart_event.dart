part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartAddingModel cart;

  AddToCartEvent({required this.cart});
}

class FetchCartEvent extends CartEvent {}
