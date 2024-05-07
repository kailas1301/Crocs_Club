import 'dart:convert';

import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/coupon_model.dart';
import 'package:http/http.dart' as http;

class CouponServices {
  Future<List<CouponModel>> getCoupons() async {
    const String apiUrl = 'http://crocs.crocsclub.shop/user/coupon';
    final token = await getToken();
    final url = Uri.parse(apiUrl);
    print('Calling API with URL: $url'); // Print the API URL being called
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? "",
        },
      );

      print(
          'Response status code: ${response.statusCode}'); // Print the HTTP status code

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print('API response data: $data'); // Print the entire response data

        if (data['status_code'] == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          final data = jsonData["data"];
          List<CouponModel> coupons = [];
          for (var item in data) {
            coupons.add(CouponModel.fromJson(item));
          }
          return coupons;
        } else {
          throw Exception('API error: ${data['message']}');
        }
      } else {
        throw Exception('Failed to get coupons: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error getting coupons: $error');
    }
  }
}
