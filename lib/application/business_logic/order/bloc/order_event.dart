part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class FetchOrdersEvent extends OrderEvent {}

class CancelOrdersEvent extends OrderEvent {}

class ReturnOrdersEvent extends OrderEvent {}
