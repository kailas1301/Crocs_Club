part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class SortProductsByPriceLowToHigh extends ProductEvent {}

class SortProductsByPriceHighToLow extends ProductEvent {}

class SortProductsByCategory extends ProductEvent {
  final int id;
  SortProductsByCategory({required this.id});
}

class GetCategory extends ProductEvent {}
