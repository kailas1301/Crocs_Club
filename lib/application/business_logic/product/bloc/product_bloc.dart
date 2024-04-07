import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/products/productservices.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:meta/meta.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productservice = ProductService();
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final productslist = await productservice.getProducts();
        emit(ProductLoaded(products: productslist));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
