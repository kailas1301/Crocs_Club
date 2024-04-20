part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<ProductFromApi> searchProductlist;
  SearchLoaded({required this.searchProductlist});
}

final class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}
