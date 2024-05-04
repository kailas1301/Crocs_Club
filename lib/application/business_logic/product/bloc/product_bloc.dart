import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/category/category.dart';
import 'package:crocs_club/data/services/products/productservices.dart';
import 'package:crocs_club/domain/models/category_model.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:meta/meta.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productservice = ProductService();
  CategoryServices categoryServices = CategoryServices();
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        print('the category is going to be fetched');
        final categoryList = await categoryServices.getCategories();
        print('the category is fetched');
        final productslist = await productservice.getProducts();
        // Print the category data
        for (var category in categoryList) {
          print(
              'Category ID: ${category.id}, Category Name: ${category.category}');
        }
        // productslist.shuffle();

        emit(ProductLoaded(products: productslist, categories: categoryList));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<SortProductsByPriceLowToHigh>((event, emit) async {
      emit(ProductLoading());
      try {
        final categoryList = await categoryServices.getCategories();
        final productslist = await productservice.getProducts();
        productslist.sort((a, b) => a.price.compareTo(b.price));
        emit(ProductLoaded(products: productslist, categories: categoryList));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<SortProductsByPriceHighToLow>((event, emit) async {
      emit(ProductLoading());
      try {
        final categoryList = await categoryServices.getCategories();
        final productslist = await productservice.getProducts();
        productslist.sort((a, b) => b.price.compareTo(a.price));
        emit(ProductLoaded(categories: categoryList, products: productslist));
      } catch (e) {
        emit(ProductError());
      }
    });

    on<SortProductsByCategory>((event, emit) async {
      emit(ProductLoading());
      try {
        final categoryList = await categoryServices.getCategories();
        final productslist = await productservice.getProducts();
        final filteredProducts = productslist
            .where((product) => int.parse(product.categoryId) == event.id)
            .toList();
        emit(ProductLoaded(
            categories: categoryList, products: filteredProducts));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
