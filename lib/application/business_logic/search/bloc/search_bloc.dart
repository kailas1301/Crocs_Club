import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/search/search_services.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService _searchService = SearchService();
  SearchBloc() : super(SearchInitial()) {
    on<ProductSearchEvent>((event, emit) async {
      print("product search event was called");
      final query = event.query;
      emit(SearchLoading());
      print('searchloading state emitted');
      try {
        final searchResult = await _searchService.searchProducts(query);
        emit(SearchLoaded(searchProductlist: searchResult));
      } on Exception catch (e) {
        emit(SearchError(message: e.toString()));
      }
    });
  }
}
