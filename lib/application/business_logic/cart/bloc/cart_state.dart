part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final CartFromApiModel cartFromApi;
  CartLoaded({required this.cartFromApi});
}

class CartAdded extends CartState {}

class CartAlreadyExists extends CartState {}

class CartError extends CartState {
  final String errorMessage;
  CartError(this.errorMessage);
}
