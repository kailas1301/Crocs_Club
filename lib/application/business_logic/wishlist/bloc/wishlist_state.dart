part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistItem> wishlist;
  WishlistLoaded(this.wishlist);
}

class WishlistError extends WishlistState {
  final String errorMessage;

  WishlistError(this.errorMessage);
}

class WishlistAdded extends WishlistState {}

class WishlistRemoved extends WishlistState {}
