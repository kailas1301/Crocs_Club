import 'dart:convert';
import 'package:crocs_club/domain/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';

class CategoryServices {
  Future<List<CategoryModel>> getCategories() async {
    String url = 'http://crocs.crocsclub.shop/user/category';
    final token = await getToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? "",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final data = jsonData["data"];
        List<CategoryModel> categories = [];
        for (var item in data) {
          categories.add(CategoryModel.fromJson(item));
        }
        return categories;
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error getting categories: $error');
    }
  }
}
