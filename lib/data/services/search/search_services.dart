import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/product.dart';

class SearchService {
  Future<List<ProductFromApi>> searchProducts(String query) async {
    try {
      print('API function for searching was called');
      final token = await getToken();
      print('Retrieved token: $token'); // Print retrieved token

      final response = await http.post(
        Uri.parse('http://crocs.crocsclub.shop/user/product/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'product_name': query}),
      );
      print('API post method was called');

      print(
          'API Response Status Code: ${response.statusCode}'); // Print response status code

      if (response.statusCode == 200) {
        print('API Response success Status Code: ${response.statusCode}');
        final List<dynamic> jsonList = jsonDecode(response.body)['data'];
        return jsonList.map((json) => ProductFromApi.fromJson(json)).toList();
      } else {
        print('API Response error Status Code: ${response.statusCode}');
        throw Exception('Failed to search products');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
