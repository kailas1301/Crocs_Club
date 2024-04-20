part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class ProductSearchEvent extends SearchEvent {
  final String query;
  ProductSearchEvent({required this.query});
}
