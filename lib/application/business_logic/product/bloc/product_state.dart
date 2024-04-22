part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductFromApi> products;
  final List<CategoryModel>? categories;

  ProductLoaded({required this.products, this.categories});
}

final class ProductError extends ProductState {}
