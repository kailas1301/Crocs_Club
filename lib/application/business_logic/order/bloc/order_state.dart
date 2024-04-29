part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}

class OrderReturned extends OrderState {}

class OrderCancelled extends OrderState {}

class OrderCancelledError extends OrderState {
  final String message;
  OrderCancelledError(this.message);
}

class OrderReturnedError extends OrderState {
  final String message;
  OrderReturnedError(this.message);
}
