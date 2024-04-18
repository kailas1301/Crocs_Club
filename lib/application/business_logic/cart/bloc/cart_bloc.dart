import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/cart/cart_services.dart';
import 'package:crocs_club/domain/models/add_to_cart_model.dart';
import 'package:crocs_club/domain/models/cart_from_api_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartServices cartServices = CartServices();
  CartBloc() : super(CartInitial()) {
    // to call the addtocart event
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());

      try {
        final result = await cartServices.addToCart(event.cart);
        if (result == 'success') {
          emit(CartAdded());
        } else if (result == 'exists') {
          print('cart already exist state emit');
          emit(CartAlreadyExists());
        }
      } catch (e) {
        emit(CartError('Failed to add product to cart'));
      }
    });

    // to fetch the items in the cart

    on<FetchCartEvent>((event, emit) async {
      print('fetched cart event called');
      emit(CartLoading()); // Use emit instead of yield
      try {
        final cart = await cartServices.fetchCart();
        emit(CartLoaded(cartFromApi: cart));
      } catch (e) {
        emit(CartError('Failed to fetch cart'));
      }
    });

    // to call the deletecart event
    on<DeleteFromCartEvent>((event, emit) async {
      emit(CartLoading()); // Emit loading state

      try {
        final result =
            await cartServices.deleteFromCart(event.itemId, event.cartId);
        if (result == 200) {
          // If deletion successful
          emit(CartLoaded(cartFromApi: await cartServices.fetchCart()));
        } else {
          emit(CartError('Failed to delete product from cart'));
        }
      } catch (e) {
        emit(CartError('Failed to delete product from cart'));
      }
    });
  }
}
