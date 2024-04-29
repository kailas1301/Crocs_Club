part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class FetchOrdersEvent extends OrderEvent {}

class CancelOrdersEvent extends OrderEvent {
  final int id;
  CancelOrdersEvent({required this.id});
}

class ReturnOrdersEvent extends OrderEvent {
  final int id;
  ReturnOrdersEvent({required this.id});
}
