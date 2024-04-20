import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/wishlist/wishlist_services.dart';
import 'package:crocs_club/domain/models/wishlist_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishListServices wishListServices = WishListServices();
  WishlistBloc() : super(WishlistInitial()) {
    on<AddToWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      try {
        final response =
            await wishListServices.addToWishList(event.inventoryId);
        if (response.statusCode == 200) {
          print("added product to wishlist");
          emit(WishlistAdded());
          final List<WishlistItem> wishlist =
              await wishListServices.getWishlist();

          emit(WishlistLoaded(wishlist));
        } else {
          print("could not add product to wishlist");
          throw Exception('Failed to add to wishlist');
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<RemoveFromWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      try {
        final response =
            await wishListServices.removeFromWishList(event.inventoryId);
        if (response.statusCode == 200) {
          print("removed  product from wishlist");
          emit(WishlistRemoved());
          final List<WishlistItem> wishlist =
              await wishListServices.getWishlist();

          emit(WishlistLoaded(wishlist));
        } else {
          print("could not remove  product from wishlist");
          throw Exception('Failed to remove from wishlist');
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<FetchWishlistEvent>((event, emit) async {
      // emit(WishlistLoading());
      try {
        final List<WishlistItem> wishlist =
            await wishListServices.getWishlist();

        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError('Failed to fetch wishlist: $e'));
      }
    });
  }
}
