import 'dart:convert';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/add_to_cart_model.dart';
import 'package:crocs_club/domain/models/cart_from_api_model.dart';
import 'package:http/http.dart' as http;

class CartServices {
  Future<String> addToCart(CartAddingModel cart) async {
    const String apiUrl = 'http://10.0.2.2:8080/user/home/addcart';
    final token = await getToken();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token.toString(),
        },
        body: jsonEncode(cart.toJson()), // Convert cart object to JSON
      );

      if (response.statusCode == 200) {
        print('Product added to cart successfully');
        return 'success';
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['error'] == "item already exists in cart") {
          print('Item already exists in cart');
          return 'exists'; // Return a specific value indicating the item already exists
        } else {
          print('Failed to add product to cart: ${response.statusCode}');
          print('Response body: ${response.body}');
          return 'error';
        }
      }
    } catch (error) {
      print('Error adding product to cart: $error');
      return 'error';
    }
  }

  Future<CartFromApiModel> fetchCart() async {
    const apiUrl = 'http://10.0.2.2:8080/user/cart';
    final token = await getToken();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token.toString(),
      },
    );
    if (response.statusCode == 200) {
      print('fetched cart: ${response.statusCode}');
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return CartFromApiModel.fromJson(jsonResponse['data']);
    } else {
      print('fetched cart error: ${response.statusCode}');
      throw Exception('Failed to load cart');
    }
  }
}
