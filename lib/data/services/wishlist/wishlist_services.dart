import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/wishlist_model.dart';
import 'package:dio/dio.dart';

class WishListServices {
  final Dio dio = Dio();
  Future<Response<dynamic>> addToWishList(int inventoryId) async {
    final url =
        "https://crocs.crocsclub.shop/user/wishlist?inventory_id=$inventoryId";
    final token = await getToken();

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } catch (error) {
      throw Exception('Failed to add to wishlist: $error');
    }
  }

  Future<Response<dynamic>> removeFromWishList(int inventoryId) async {
    final url =
        "https://crocs.crocsclub.shop/user/wishlist?inventory_id=$inventoryId";
    final token = await getToken();

    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to remove from wishlist: $error');
    }
  }

  Future<List<WishlistItem>> getWishlist() async {
    const url = "https://crocs.crocsclub.shop/user/wishlist";
    final token = await getToken();

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final List<WishlistItem> wishlist = [];
        for (var item in data) {
          final wishlistItem = WishlistItem.fromJson(item);
          wishlist.add(wishlistItem);
        }
        return wishlist;
      } else {
        throw Exception('Failed to get wishlist: ${response.data['message']}');
      }
    } catch (error) {
      throw Exception('Failed to get wishlist: $error');
    }
  }
}
