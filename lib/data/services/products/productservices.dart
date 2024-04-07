import 'package:crocs_club/domain/models/product.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio dio = Dio(); // Create a single instance for efficiency

  Future<List<ProductFromApi>> getProducts() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://10.0.2.2:8080/admin/inventories');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['error'] == null) {
          final productList = responseData['data'] as List<dynamic>;
          return productList
              .map((productData) => ProductFromApi.fromJson(productData))
              .toList();
        } else {
          throw Exception('API error: ${responseData['error']}');
        }
      } else {
        throw Exception(
            'API request failed with status code: ${response.statusCode}');
      }
    } on DioException catch (error) {
      throw Exception('Error fetching products: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error: $error');
    }
  }
}
