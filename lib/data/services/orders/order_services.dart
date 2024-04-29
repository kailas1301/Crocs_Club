import 'dart:convert';

import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/orders_model.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  static const String baseUrl = 'http://10.0.2.2:8080/user/profile/order/all';
  static Future<List<Order>> fetchOrders() async {
    final token = await getToken();
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'accept': 'application/json',
      'Authorization': token ?? "",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      List<Order> orders = [];
      for (var item in data) {
        final order = Order.fromJson(item);
        orders.add(order);
      }
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  static Future<int> cancelOrder(int id) async {
    final String url = 'http://10.0.2.2:8080/user/profile/order?order_id=$id';
    final token = await getToken();
    final response = await http.delete(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Authorization': token ?? "",
    });

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<int> returnOrder(int id) async {
    final String url =
        'http://10.0.2.2:8080/user/profile/order/return?order_id=$id';
    final token = await getToken();
    final response = await http.patch(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Authorization': token ?? "",
    });

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
